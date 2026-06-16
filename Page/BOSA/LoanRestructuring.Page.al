page 51600 "Loan Restructuring"
{
    // version TL2.0
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Posting,Category7';
    SourceTable = "Loan Restructuring";

    layout
    {
        area(content)
        {
            group(General)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
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
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        RestructuringOptionVisibility;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
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
                group(ApprovedBy)
                {
                    Caption = 'Approved By';
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
                }
            }
            group(Restrusturing)
            {
                Caption = 'Restrusturing';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field("Approved Loan Amount"; Rec."Approved Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Loan Balance"; Rec."Outstanding Loan Balance")
                {
                    ApplicationArea = All;
                }
                field("Restructuring Type"; Rec."Restructuring Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                group(RepaymentPeriod)
                {
                    Caption = '';
                    Visible = IsRepaymentPeriodVisible;
                    field("Current Repayment Period"; Rec."Current Repayment Period")
                    {
                        ApplicationArea = All;
                    }
                    field("New Repayment Period"; Rec."New Repayment Period")
                    {
                        ApplicationArea = All;
                    }
                }
                group(RepaymentFrequency)
                {
                    Caption = '';
                    Visible = IsRepaymentFrequencyVisible;
                    field("Current Repayment Frequency"; Rec."Current Repayment Frequency")
                    {
                        ApplicationArea = All;
                    }
                    field("New Repayment Frequency"; Rec."New Repayment Frequency")
                    {
                        ApplicationArea = All;
                    }
                }
                group(InterestRate)
                {
                    Caption = '';
                    Visible = IsInterestRateVisible;
                    field("Current Interest Rate"; Rec."Current Interest Rate")
                    {
                        ApplicationArea = All;
                    }
                    field("New Interest Rate"; Rec."New Interest Rate")
                    {
                        ApplicationArea = All;
                    }
                }
                field(Remarks; Rec.Remarks)
                {
                    ColumnSpan = 1;
                    MultiLine = true;
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
                    Rec.ValidateReschedulingOption;
                    //ValidateAttachment;
                    Rec.TESTFIELD(Remarks);
                    IF ApprovalsMgmt.CheckLoanRestructuringApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendLoanRestructuringForApproval(Rec);
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
                    ApprovalsMgmt.OnCancelLoanRestructuringApprovalRequest(Rec);
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
                    end;
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
                    end
                end;
            }
            action("Preview Schedule")
            {
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Preview loan repayment schedule';
                trigger OnAction()
                var
                    BOSAManagement: Codeunit "BOSA Management";
                    LoanApplication: Record "Loan Application";
                begin
                    BOSAManagement.CreateRepaymentScheduleRestructure(Rec."Loan No.", Rec."Outstanding Loan Balance");
                    COMMIT;

                    LoanApplication.GET(Rec."Loan No.");
                    LoanApplication.SETRECFILTER;
                    REPORT.RUN(REPORT::"Loan Repament Schedule", TRUE, FALSE, LoanApplication);
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

    var
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleSendApprovalRequest: Boolean;
        IsVisiblePost: Boolean;
        IsVisibleApproveAction: Boolean;
        IsVisibleRejectAction: Boolean;
        IsVisibleDelegateAction: Boolean;
        IsRepaymentPeriodVisible: Boolean;
        IsRepaymentFrequencyVisible: Boolean;
        IsInterestRateVisible: Boolean;

    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleSendApprovalRequest := TRUE;
            IsVisiblePost := FALSE;
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
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisiblePost := TRUE;
        END;
        RestructuringOptionVisibility;
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;

    local procedure RestructuringOptionVisibility()
    begin
        IF (Rec."Restructuring Type" = Rec."Restructuring Type"::"Repayment Period") THEN
            IsRepaymentPeriodVisible := TRUE
        ELSE
            IsRepaymentPeriodVisible := FALSE;
        IF (Rec."Restructuring Type" = Rec."Restructuring Type"::"Repayment Frequency") THEN
            IsRepaymentFrequencyVisible := TRUE
        ELSE
            IsRepaymentFrequencyVisible := FALSE;
        IF (Rec."Restructuring Type" = Rec."Restructuring Type"::"Interest Rate") THEN
            IsInterestRateVisible := TRUE
        ELSE
            IsInterestRateVisible := FALSE;
    end;
}

