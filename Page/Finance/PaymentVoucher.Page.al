page 50602 "Payment Voucher"
{
    // version TL2.0

    SourceTable = "Payment Header";
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
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;
                }
                field("Payee Name"; Rec."Payee Name")
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
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount to Pay';
                    ShowMandatory = true;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("Total W/Tax Amount"; Rec."Total W/Tax Amount")
                {
                    ApplicationArea = All;
                }
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

            part("Payment Voucher Subform"; "Payment Voucher Subform")
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
                    Visible = Rec.Posted = true;
                    trigger OnAction();
                    begin
                        Rec.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(50447, TRUE, TRUE, Rec);
                    end;
                }

                action(Post)
                {
                    Image = Post;
                    //  Visible = not Posted;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    //Visible = PostingPV;
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    begin

                        if Confirm(PostPaymentVoucherConfirmMsg, true, Rec."No.") then
                            CashManagement.PostPaymentVoucher(Rec)
                        else
                            exit;
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
                            CashManagement.ReversePaymentVoucher(Rec)
                        else
                            exit;
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT NewApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';
                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext-Finance";
                    begin
                        ValidateFields();
                        IF ApprovalsMgmt.CheckPaymentVoucherApprovalPossible(Rec) THEN BEGIN
                            ApprovalsMgmt.OnSendPaymentVoucherForApproval(Rec);
                        END;
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
                    Visible = false;
                    ToolTip = 'Cancel the approval request.';
                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext-Finance";
                        WorkflowWebhookMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPaymentVoucherApprovalRequest(Rec);
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
                    // Visible = IsApproveVisible;
                    Visible = false;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                            CurrPage.CLOSE;
                        END;
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
                    // Visible = IsRejectVisible;
                    Visible = false;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                            CurrPage.CLOSE;
                        END;
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    //Visible = IsDelegateVisible;
                    Visible = false;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                            CurrPage.CLOSE;
                        END;
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments for the record.';
                    //Visible = NewApprovalEntriesExistForCurrUser;
                    Visible = false;
                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
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
            IF Rec.Posted = FALSE THEN BEGIN
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
        PostPaymentVoucherConfirmMsg: Label 'Do you want to post payment voucher %1?';
        ReversePaymentVoucherConfirmMsg: Label 'Do you want to post reverse payment voucher %1?';
}

