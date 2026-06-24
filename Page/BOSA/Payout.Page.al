page 50280 Payout
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Posting,Category7';
    RefreshOnActivate = true;
    SourceTable = "Payout Header";

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
                field("Payout Type"; Rec."Payout Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Charge Calculation Method"; Rec."Charge Calculation Method")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Flat Charge Amount"; Rec."Flat Charge Amount")
                {
                    ApplicationArea = All;
                    Visible = Rec."Charge Calculation Method" = 0;
                }
                field("Charge Percentage"; Rec."Charge Percentage")
                {
                    ApplicationArea = All;
                    Visible = Rec."Charge Calculation Method" = 1;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Total Payout Amount"; Rec."Total Payout Amount")
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
                group(ApprovedBy)
                {
                    Caption = 'Approved by';
                    Visible = Rec."Status" = 2;
                    field("Approved By"; Rec."Approved By")
                    {
                        ApplicationArea = All;
                    }
                    field("Approved Date"; Rec."Approved Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Approved Time"; Rec."Approved Time")
                    {
                        ApplicationArea = All;
                    }
                }
                group(PostedBy)
                {
                    Caption = 'Posted By';
                    Visible = Rec."Posted" = TRUE;
                    field("Posted By"; Rec."Posted By")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Date"; Rec."Posted Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Time"; Rec."Posted Time")
                    {
                        ApplicationArea = All;
                    }
                    field(Posted; Rec.Posted)
                    {
                    }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            // Add the new part for Charge Ranges below
            part(PayoutChargeRange; "Payout Charge Range")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                Visible = Rec."Charge Calculation Method" = 2;
            }
            // This is the existing part for Payout Lines
            part(PayoutSubform; "Payout Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
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
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.CALCFIELDS("Total Payout Amount");
                    IF Rec."Total Payout Amount" > Rec."Agency Account Balance" THEN
                        ERROR(Error000, Rec.FIELDCAPTION("Total Payout Amount"), Rec.FIELDCAPTION("Agency Account Balance"));
                    IF ApprovalsMgmt.CheckPayoutApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendPayoutForApproval(Rec);
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
                    ApprovalsMgmt.OnCancelPayoutApprovalRequest(Rec);
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
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
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
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    END;
                    CurrPage.CLOSE;
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
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                Visible = IsVisiblePost;

                trigger OnAction()
                begin
                    BOSAManagement.PostPayout(Rec);
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
                Visible = IsvisiblePrint;

                trigger OnAction()
                begin
                    PayoutHeader.GET(Rec."No.");
                    PayoutHeader.SETRECFILTER;
                    //REPORT.RUN(REPORT::"Payout Report", TRUE, FALSE, PayoutHeader);
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

    var
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleSendApprovalRequest: Boolean;
        IsVisiblePost: Boolean;
        IsVisibleApproveAction: Boolean;
        IsVisibleRejectAction: Boolean;
        IsVisibleDelegateAction: Boolean;
        BOSAManagement: Codeunit "BOSA Management";
        Error000: Label '%1 cannot exceed %2';
        PayoutHeader: Record "Payout Header";
        IsvisiblePrint: Boolean;

    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleSendApprovalRequest := TRUE;
            IsVisiblePost := FALSE;
            IsvisiblePrint := FALSE;
        END ELSE BEGIN
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleSendApprovalRequest := FALSE;
            IsvisiblePrint := TRUE;
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