page 50625 "Receipt Voucher"
{
    // version TL2.0

    SourceTable = "Receipt Header";
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
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                group(bank)
                {
                    Caption = '';
                    Visible = Rec."Account Type" = Rec."Account Type"::"Bank Account";
                    field("Bank Account No."; Rec."Bank Account No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Bank Account Name"; Rec."Bank Account Name")
                    {
                        ApplicationArea = All;
                    }
                }
                group(GlAcc)
                {
                    Caption = '';
                    Visible = Rec."Account Type" = Rec."Account Type"::"G/L Account";
                    field("GL Account No"; Rec."GL Account No")
                    {
                        ApplicationArea = All;
                    }
                    field("GL Account Name"; Rec."GL Account Name")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                group(SingleMember)
                {
                    Caption = '';
                    Visible = Rec."Transaction Type" = 0;
                    field("Member No."; Rec."Member No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Member Name"; Rec."Member Name")
                    {
                        ApplicationArea = All;
                    }
                }
                /*  field("Payee Name"; Rec."Payee Name")
                 {
                     ApplicationArea = All;
                     Caption = 'Received From';
                 } */

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }


                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount to Receive';

                    trigger OnValidate()
                    var
                        RecHeader: Record "Receipt Header";
                        RecLine: Record "Receipt Line";
                        TLineAmount: Decimal;
                    begin
                        Clear(Rec.Variance);
                        CurrPage.Update();

                        RecLine.Reset();
                        RecLine.SetRange("Document No.", Rec."No.");
                        if RecLine.FindSet() then begin
                            RecLine.CalcSums(RecLine."Line Amount");
                            TLineAmount := RecLine."Line Amount";
                        end;

                        Rec.Variance := Rec.Amount - TLineAmount;
                        Rec.Modify();

                        CurrPage.Update();
                    end;
                }

                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;
                }
                field(Variance; Rec.Variance)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }
            }
            part("Receipt Voucher Subform"; "Receipt Voucher Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }

        }
    }

    actions
    {
        area(Reporting)
        {


            action(Print)
            {
                Image = Print;
                Visible = Rec.Posted = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                trigger OnAction();
                begin
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50440, TRUE, TRUE, Rec);
                end;
            }
        }
        area(processing)
        {
            action(Post)
            {
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = IsVisiblePost;
                ApplicationArea = Basic, Suite;
                trigger OnAction();
                begin
                    if Confirm(PostReceiptVoucherConfirmMsg, true, Rec."No.") then begin
                        CashManagement.PostReceiptVoucher(Rec);
                        CurrPage.Close();
                    end else
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
                    if Confirm(ReverseReceiptVoucherConfirmMsg, true, Rec."No.") then begin
                        CashManagement.ReverseReceiptVoucher(Rec);
                        CurrPage.Close();
                    end else
                        exit;
                end;
            }
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
                    Visible = false;

                    trigger OnAction();
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
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
                    Visible = NewApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
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
                    Visible = NewApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
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
                    Visible = NewApprovalEntriesExistForCurrUser;

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
        //NewApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasNewApprovalEntriesForCurrentUser(Rec.RECORDID);
        //  NewApprovalEntriesExist := ApprovalsMgmt.HasNewApprovalEntries(Rec.RECORDID);
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
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
        if Rec."Account Type" = Rec."Account Type"::"Bank Account" then begin
            IsBankVisible := true;
            IsGlVisible := false;
        end;
    end;

    trigger OnOpenPage();
    begin
        CanRequestApprovalForFlow := TRUE;
        IF Rec.Status <> Rec.Status::New THEN BEGIN
            CanRequestApprovalForFlow := FALSE;
            CurrPage.EDITABLE(FALSE);
        END;
        IF Rec.Posted = FALSE THEN BEGIN
            IsVisiblePost := TRUE;
            IsVisiblePrint := false;
            CurrPage.EDITABLE(TRUE);
        END ELSE BEGIN
            CurrPage.EDITABLE(FALSE);
        END;
    end;

    var
        CashManagement: Codeunit "Cash Management";
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisiblePost: Boolean;
        IsVisiblePrint: Boolean;
        IsBankVisible: Boolean;
        IsGlVisible: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        NewApprovalEntriesExist: Boolean;
        CanCancelApprovalForFlow: Boolean;
        NewApprovalEntriesExistForCurrUser: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ModifyFields: Boolean;
        PostReceiptVoucherConfirmMsg: Label 'Do you want to post receipt voucher %1?';
        ReverseReceiptVoucherConfirmMsg: Label 'Do you want to post reverse receipt voucher %1?';
}

