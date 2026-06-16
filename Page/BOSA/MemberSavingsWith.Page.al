page 55230 "Member Savings Withdrawal"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Posting,Category7';
    RefreshOnActivate = true;
    SourceTable = "Member Exit Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {

                }
                field("Withdrawal Amount"; Rec."Withdrawal Amount")
                {

                }
                field("Total Deductions"; Rec."Total Deductions")
                {

                }

                field("Net Payment"; Rec."Net Payment")
                {

                }
                field("Paying Account"; Rec."Paying Account")
                {
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {

                }
                field("Payment Date"; Rec."Payment Date")
                {

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
            }
            /* part(MExit; "Member Exit Subform")
             {
                 ApplicationArea = All;
                 SubPageLink = "Document No." = FIELD("No.");
             }*/
        }
        area(factboxes)
        {
            part(AttachmentFactBox; "Attachement FactBox")
            {
                Caption = 'Attachment';
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
                    Rec.TESTFIELD(Remarks);
                    //ValidateAttachment;
                    IF ApprovalsMgmt.CheckMemberExitApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendMemberExitForApproval(Rec);
                    CurrPage.CLOSE;
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
                    ApprovalsMgmt.OnCancelMemberExitApprovalRequest(Rec);
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
                    END;

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
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    END;

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
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    END;

                end;
            }
            action(PostExit)
            {
                ApplicationArea = Suite;
                Caption = 'Post';
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Post Withdrawal.';
                Visible = IsPostVisible;

                trigger OnAction()
                var
                    Bosa: Codeunit "BOSA Management";
                begin
                    Rec.TestField("Payment Date");
                    if Confirm('Are You Sure You Want to Post This Withdrawal Application', true) then begin
                        Bosa.PostMemberSavingsWithdrawal(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
        }
        area(reporting)
        {
            action(Print)
            {

                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    MemberExitHeader.GET(Rec."No.");
                    MemberExitHeader.SETRECFILTER;
                    //REPORT.RUN(REPORT::"Exit Request", TRUE, FALSE, MemberExitHeader);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
    end;

    trigger OnOpenPage()
    begin
        PageVisibility;
        PageEditable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Exit Type" := Rec."Exit Type"::"Temporary Exit";
    end;

    var
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleApproveAction: Boolean;
        IsVisibleRejectAction: Boolean;
        IsVisibleDelegateAction: Boolean;
        IsPostVisible: Boolean;
        MemberExitHeader: Record "Member Exit Header";

    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleSendApprovalRequest := TRUE;
        END ELSE BEGIN
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
        if (Rec.Status = Rec.Status::Approved) and (Rec.Posted = false) then
            IsPostVisible := true
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;
}

