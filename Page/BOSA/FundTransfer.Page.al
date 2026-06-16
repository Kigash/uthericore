page 50219 "Fund Transfer"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Posting,Category7';
    SourceTable = "Fund Transfer";

    layout
    {
        area(content)
        {
            group(Source)
            {
                Caption = 'Source';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = All;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = All;
                }
                field("Source Account Balance"; Rec."Source Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Destination Account Ownership"; Rec."Destination Account Ownership")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
            }
            group(Destination)
            {
                Caption = 'Destination';
                part("Funds Transfer Subform"; "Funds Transfer Subform")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No." = FIELD("No.");
                    UpdatePropagation = Both;
                }
            }
            group(Audit)
            {
                field("Approved By"; Rec."Approved By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
            }

        }
        area(factboxes)
        {
            part(AttachmentFactBox; 50265)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Send an approval request.';
                Visible = IsVisibleSendApprovalRequest;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    ValidateFields();
                    IF ApprovalsMgmt.CheckFundTransferApprovalPossible(Rec) THEN begin
                        ApprovalsMgmt.OnSendFundTransferForApproval(Rec);
                        CurrPage.CLOSE;
                    end;

                end;
            }


            action(CancelApprovalRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = IsVisibleCancelApprovalRequest;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    ApprovalsMgmt.OnCancelFundTransferApprovalRequest(Rec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';
                Visible = IsVisibleApproveAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    end;
                end;

            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';
                Visible = IsVisibleRejectAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    end
                end;
            }
            action(Delegate)
            {
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = IsVisibleDelegateAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST then begin
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    END;
                end;
            }
            action(ReOpenRecord)
            {
                ApplicationArea = Suite;
                Caption = 'Set Record Status To Open';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Set Record Status To Open.';
                Visible = IsReopenVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    Rec.Status := Rec.Status::New;
                    Rec.Posted := false;
                    Rec.Modify();

                end;
            }
            action(Reverse)
            {
                Image = ReverseLines;
                Visible = Rec.Posted = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                trigger OnAction();
                var
                    GLEntry: Record "G/L Entry";
                    ReversalEntry: Record "Reversal Entry";
                begin
                    GLEntry.Reset();
                    GLEntry.SetRange(GLEntry."Document No.", Rec."No.");
                    GLEntry.SetRange(Reversed, false);
                    if GLEntry.FindSet() then begin
                        repeat
                            ReversalEntry.SetHideWarningDialogs();
                            ReversalEntry.SetHideDialog(true);
                            ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
                        until GLEntry.Next() = 0;
                        Rec.Posted := false;
                        Rec.Status := Rec.Status::New;
                        Rec.Modify();
                    end;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F9';
                ToolTip = 'Post Fund Transfer';
                Visible = IsVisiblePost;


                trigger OnAction()
                begin
                    Rec.TESTFIELD("Member No.");
                    Rec.TESTFIELD("Source Account No.");
                    Rec.TESTFIELD("Amount to Transfer");
                    if Confirm(PostFTConfirmMsg, true, Rec."No.") then
                        BOSAManagement.PostFundTransfer(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        PageEditable;
        PageVisibility;
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
    end;

    trigger OnOpenPage()
    begin
        PageVisibility;
        PageEditable;
    end;

    local procedure ValidateFields()
    var

    begin
        Rec.TESTFIELD("Member No.");
        Rec.TESTFIELD("Source Account No.");
        //TestField("Destination Member No.");
        //TestField("Destination Account No.");
        Rec.TESTFIELD("Amount to Transfer");
        //Rec.TESTFIELD(Remarks);
        If Rec."Amount to Transfer" > Rec."Source Account Balance" then
            Error('Ammount To Transfer Cannot Exceed Source Account Balance');
    end;

    var
        IsVisibleCancelApprovalRequest: Boolean;
        IsTranactionTypeCodeVisible: Boolean;
        IsReopenVisible: Boolean;
        IsVisibleSendApprovalRequest: Boolean;
        IsVisiblePost: Boolean;
        IsVisibleApproveAction: Boolean;
        IsVisibleRejectAction: Boolean;
        IsVisibleDelegateAction: Boolean;
        BOSAManagement: Codeunit "BOSA Management";
        Error000: Label '%1 cannot exceed %2';
        Text000: Label 'Fund Transfer';
        Error003: Label 'Loan to Loan Transfer is not allowed';
        Error004: Label '%1 must be a Loan Account';
        Error005: Label '%1 must NOT be a Loan Account';
        Error006: Label 'Loan %1 has no overpayment';
        Error007: Label '%1 cannot exceed the %2';
        Error008: Label '%1 must be %2 %3';
        Error009: Label '%1 must NOT be %2 %3';
        Error010: Label '%1 and %2 cannot be the same';
        Customer: Record Customer;
        Vendor: Record Vendor;
        PostFTConfirmMsg: Label 'Do you want to post Fund Transfer %1?';


    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleSendApprovalRequest := TRUE;
            IsVisiblePost := FALSE;
        END ELSE BEGIN
            IsReopenVisible := true;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleSendApprovalRequest := FALSE;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsVisibleApproveAction := TRUE;
            IsVisibleRejectAction := TRUE;
            IsVisibleDelegateAction := TRUE;
        END ELSE BEGIN
            IsVisibleApproveAction := FALSE;
            IsVisibleRejectAction := FALSE;
            IsVisibleDelegateAction := FALSE;
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisiblePost := TRUE;
        END;
        IF Rec.Posted THEN
            IsVisiblePost := FALSE;
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;


}

