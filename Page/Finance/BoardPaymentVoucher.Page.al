page 56602 "Board Payment Voucher"
{
    // version TL2.0

    SourceTable = "Board Payment Header";
    PromotedActionCategories = 'New,Process,Reports,Approval,Reversal,Category 6,Category 7,Category 8';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Total Board Sitting"; Rec."Total Board Sitting")
                {
                    Caption = 'Total Board Sitting Allowance';
                    ApplicationArea = All;
                }
                field("Total Board Tax"; Rec."Total Board Tax")
                {
                    Caption = 'Total Tax on Sitting Allowance';
                    ApplicationArea = All;
                }
                field("Total Board Transport"; Rec."Total Board Transport")
                {
                    Caption = 'Total Board Transport Reimbursement';
                    ApplicationArea = All;
                }
                field("Total Board Hospitality"; Rec."Total Board Hospitality")
                {
                    Caption = 'Total Board Hospitality Costs';
                    ApplicationArea = All;
                }
                field("Gross Board Amount"; Rec."Gross Board Amount")
                {
                    Caption = 'Total Board Gross Pay';
                    ApplicationArea = All;
                }
                field("Net Board Amount"; Rec."Net Board Amount")
                {
                    Caption = 'Total Board Net Pay';
                    ApplicationArea = All;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;
                }
                field(TotalPaymentAmount; Rec."Total Line Amount" + Rec."Net Board Amount")
                {
                    Caption = 'Total Payment Amount';
                    ApplicationArea = All;
                    Editable = false;
                }

                group(Audit)
                {
                    field("Created By"; Rec."Created By")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Created Date"; Rec."Created Date")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Created Time"; Rec."Created Time")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Approved By"; Rec."Approved By")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Date Approved"; Rec."Date Approved")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Time Approved"; Rec."Time Approved")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                    }
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }

            }
            part("Board Member PV Subform"; "Board Member PV Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            part("Board Payment Voucher Subform"; "Board Payment Voucher Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }

        }
    }

    actions
    {
        area(creation)
        {

            group(main)
            {
                action(Print)
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    trigger OnAction();
                    begin
                        Rec.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(50447, TRUE, TRUE, Rec);
                    end;
                }

                action(Post)
                {
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = Rec.Status = 2;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    var
                        Gle: Record "G/L Entry";
                        VendL: Record "Vendor Ledger Entry";
                        DVendL: Record "Detailed Vendor Ledg. Entry";
                        BankL: Record "Bank Account Ledger Entry";
                    begin
                        if Confirm(PostPaymentVoucherConfirmMsg, true, Rec."No.") then begin
                            CashManagement.PostBoardPaymentVoucher(Rec);
                        end else begin
                            exit;
                        end;
                    end;
                }
                action(Reverse)
                {
                    Image = ReverseRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = Rec.Posted = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    begin
                        if Confirm(ReversePaymentVoucherConfirmMsg, true, Rec."No.") then
                            CashManagement.ReverseBoardPaymentVoucher(Rec)
                        else
                            exit;
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT NewApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = Rec.Status = 0;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext-Finance";

                    begin
                        Rec.TestField("Account No.");
                        Rec.TestField(Description);
                        Rec.TestField("Payment Method");

                        BoardPVLines.Reset();
                        BoardPVLines.SetRange("Document No.", Rec."No.");
                        BoardPVLines.SetRange("Net Pay", 0);
                        if BoardPVLines.FindSet() then begin
                            BoardPVLines.DeleteAll();
                        end;


                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Approve Board Payments" = true then begin
                                Rec.Status := Rec.Status::Approved;
                                Rec."Date Approved" := Today;
                                Rec."Time Approved" := Time;
                                Rec."Approved By" := UserId;
                                Rec.Modify();
                                Message('Board payment approval request has been approved successfuly');
                            end else begin
                                Rec.Status := Rec.Status::"Pending Approval";
                                Rec.Modify();
                                Message('Board payment approval request has been initiated Successfuly');
                            end;
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = Rec.Status = 1;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext-Finance";
                        WorkflowWebhookMgt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify();
                        Message('Board payment approval request has been canceled successfuly');
                    end;
                }
            }
        }
        area(processing)
        {

            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = IsApproveVisible;

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Approve Board Payments" = true then begin
                                Rec.Status := Rec.Status::Approved;
                                Rec."Date Approved" := Today;
                                Rec."Time Approved" := Time;
                                Rec."Approved By" := UserId;
                                Rec.Modify();
                                Message('Board payment approval request has been approved successfuly');
                            end else begin
                                Error('You do not have permission to complete this action. Contact Administrator');
                            end;
                        end;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = IsRejectVisible;

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Approve Board Payments" = true then begin
                                Rec.Status := Rec.Status::Rejected;
                                Rec."Rejected By" := UserId;
                                Rec."Date Rejected" := Today;
                                Rec."Time Rejected" := Time;
                                Rec.Modify();
                                Message('Board payment approval request has been rejected successfuly');
                            end else begin
                                Error('You do not have permission to complete this action. Contact Administrator');
                            end;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        // NewApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasNewApprovalEntriesForCurrentUser(Rec.RECORDID);
        // NewApprovalEntriesExist := ApprovalsMgmt.HasNewApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RECORDID, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        IF Rec.Status <> Rec.Status::New THEN BEGIN
            CanRequestApprovalForFlow := FALSE;
        END;
        IF Rec.Status = Rec.Status::New THEN BEGIN
            ModifyFields := TRUE;
        END;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        IF Rec.Status <> Rec.Status::New THEN BEGIN
            IF CanRequestApprovalForFlow = TRUE THEN BEGIN
                CanRequestApprovalForFlow := FALSE;
            END;
            CurrPage.EDITABLE(FALSE);
        END;
        Rec.CalcFields("Total Line Amount", "Net Board Amount");
        TotalPaymentAmount := Rec."Total Line Amount" + Rec."Net Board Amount";
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin

    end;

    trigger OnOpenPage();
    begin
        CanRequestApprovalForFlow := TRUE;
        IF Rec.Status <> Rec.Status::New THEN BEGIN
            CanRequestApprovalForFlow := FALSE;
            CurrPage.EDITABLE(FALSE);
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IF Rec."Posted" = FALSE THEN BEGIN
                PostingPV := TRUE;
            END;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" then begin
            IsApproveVisible := true;
            IsDelegateVisible := true;
            IsRejectVisible := true;
        end;
    end;

    local procedure ValidateFields()
    var
    begin
        // Rec.TestField("Account No."); Rec.TestField("Payee Name"); Rec.TestField(Description);
        Rec.CalcFields("Total Line Amount");
        Rec.TestField(Amount, Rec."Total Line Amount");
        Rec.TestField("Payment Method");
    end;

    var
        CashManagement: Codeunit "Cash Management";
        BoardPVLines: Record "Board Members Payment Line";
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        NewApprovalEntriesExist: Boolean;
        CanCancelApprovalForFlow: Boolean;
        NewApprovalEntriesExistForCurrUser: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ModifyFields: Boolean;
        //PaymentRemittanceAdvise : Report "50441";
        PostingPV: Boolean;
        IsApproveVisible: Boolean;
        IsDelegateVisible: Boolean;
        IsRejectVisible: Boolean;
        AccType: Record "Account Type";
        PostPaymentVoucherConfirmMsg: Label 'Do you want to post payment voucher %1?';
        ReversePaymentVoucherConfirmMsg: Label 'Do you want to post reverse payment voucher %1?';
        UserSetup: Record "User Setup";
        TotalPaymentAmount: Decimal;
}
