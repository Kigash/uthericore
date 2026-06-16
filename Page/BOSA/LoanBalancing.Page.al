page 51690 "Loan Balancing"
{
    // version TL2.0
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Posting,Category7';
    SourceTable = "Loan Balancing";

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
                field("Loan Account No."; Rec."Loan Account No.")
                {
                    ApplicationArea = All;
                }
                field("Loan Description"; Rec."Loan Description")
                {
                    ApplicationArea = All;
                }
                field("Loan Account Balance"; Rec."Loan Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Loan Balancing Amount"; Rec."Loan Balancing Amount")
                {
                    ApplicationArea = All;
                }
                field("Loan Balancing Charge"; Rec."Loan Balancing Charge")
                {
                    ApplicationArea = All;
                }
                field("Total Deduction Amount"; Rec."Total Deduction Amount")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
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
            }

            field(Remarks; Rec.Remarks)
            {
                ColumnSpan = 1;
                MultiLine = true;
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
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    //ValidateAttachment;
                    Rec.TESTFIELD(Remarks);
                    //IF ApprovalsMgmt.CheckLoanRestructuringApprovalPossible(Rec) THEN
                    //ApprovalsMgmt.OnSendLoanRestructuringForApproval(Rec);
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
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    //ApprovalsMgmt.OnCancelLoanRestructuringApprovalRequest(Rec);
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
                Visible = false;

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
                Visible = false;

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
                Visible = false;

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
            action("Post")
            {
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = Rec.Posted = false;
                trigger OnAction()
                var
                    BOSAManagement: Codeunit "BOSA Management";
                    LoanApplication: Record "Loan Application";
                    LoanRSetup: Record "Loan Restructuring Setup";
                    TransactionTypeCodeSetup: Record "Transaction Type Code Setup";
                    SourceCodeSetup: Record "Source Code Setup";
                    LoanApplication2: Record "Loan Application";
                begin
                    Rec.TESTFIELD(Remarks);
                    LoanRSetup.Get();
                    TransactionTypeCodeSetup.Get();
                    SourceCodeSetup.Get();
                    LoanApplication2.Get(Rec."Loan Account No.");
                    GlobalManagement.ClearJournal(LoanRSetup."Loan Restr. Template Name", LoanRSetup."Loan Restr. Batch Name");
                    GlobalManagement.DeductLoanArrearsBalancing(TransactionTypeCodeSetup, SourceCodeSetup, LoanRSetup."Loan Restr. Template Name", LoanRSetup."Loan Restr. Batch Name", Rec."No.", Rec."No.", Rec."Posting Date", Rec."Loan Account No.", Rec."Loan Balancing Amount", LoanApplication2."Global Dimension 1 Code");
                    If GlobalManagement.PostJournal(LoanRSetup."Loan Restr. Template Name", LoanRSetup."Loan Restr. Batch Name") then begin
                        Rec."Posted By" := UserId;
                        Rec."Posted Time" := Time;
                        Rec."Posted Date" := Today;
                        Rec.Posted := true;
                        Rec.Modify();

                    end;
                    CurrPage.Close();
                end;
            }
            action(Reverse)
            {
                ApplicationArea = All;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Category8;
                Visible = Rec.Posted = true;
                ToolTip = 'Reverse Loan Balancing';
                trigger OnAction();
                var

                begin
                    if Confirm(ReverseLoanConfirmMsg, true, Rec."No.") then
                        BOSAManagement.ReverseLoanBalancing(Rec);
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
        ReverseLoanConfirmMsg: Label 'Do you want to reverse loan balancing %1?';
        BOSAManagement: Codeunit "BOSA Management";
        IsVisibleSendApprovalRequest: Boolean;
        IsVisiblePost: Boolean;
        IsVisibleApproveAction: Boolean;
        IsVisibleRejectAction: Boolean;
        IsVisibleDelegateAction: Boolean;
        IsRepaymentPeriodVisible: Boolean;
        IsRepaymentFrequencyVisible: Boolean;
        IsInterestRateVisible: Boolean;
        GlobalManagement: Codeunit "Global Management";


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
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;
}

