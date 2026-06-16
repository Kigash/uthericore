page 50630 "Checkoff Receipt Voucher"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Checkoff Receipt Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;

                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;

                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ApplicationArea = All;

                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;

                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;

                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                }

                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }
                field("Created Time"; Rec."Created Time")
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
            part("Checkoff Receipt V. Subform"; "Checkoff Receipt V. Subform")
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
                    REPORT.RUN(50449, TRUE, TRUE, Rec);
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
                    if Confirm(PostCheckoffReceiptVoucherConfirmMsg, true, Rec."No.") then begin
                        CashManagement.PostCheckoffReceiptVoucher(Rec);
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
                    if Confirm(ReverseCheckoffReceiptVoucherConfirmMsg, true, Rec."No.") then begin
                        CashManagement.ReverseCheckoffReceiptVoucher(Rec);
                        CurrPage.Close();
                    end else
                        exit;
                end;
            }
            action(CopyPostedCheckoffRV)
            {
                Caption = 'Copy Document';
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = Rec.Posted = false;
                ApplicationArea = Basic, Suite;
                trigger OnAction();
                begin
                    CashManagement.GetPostedCheckoffReceiptVoucher(Rec)

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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        NewApprovalEntriesExist: Boolean;
        CanCancelApprovalForFlow: Boolean;
        NewApprovalEntriesExistForCurrUser: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ModifyFields: Boolean;
        PostCheckoffReceiptVoucherConfirmMsg: Label 'Do you want to post Checkoff receipt voucher %1?';
        ReverseCheckoffReceiptVoucherConfirmMsg: Label 'Do you want to reverse Checkoff receipt voucher %1?';

}