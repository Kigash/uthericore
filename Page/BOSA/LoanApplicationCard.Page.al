page 50203 "Loan Application Card"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Security,Approval Request,Approval,Posting,Reversal,Refinancing,Notification';
    RefreshOnActivate = true;
    SourceTable = "Loan Application";

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
                    Editable = Rec.Status = 0;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Borrower Type"; Rec."Borrower Type")
                {
                    ApplicationArea = All;
                }
                field("Loan Officer"; Rec."Loan Officer")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = 0;

                    trigger OnValidate()
                    begin
                        ValidateLoanProduct;
                    end;

                }
                group(Refinance)
                {
                    Caption = '';
                    Editable = Rec."Status" = 0;
                    field("Top-up"; Rec."Top-up")
                    {
                        ApplicationArea = All;

                    }
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = All;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = 0;
                }
                group(Savings)
                {
                    Caption = '';
                    Visible = IsSavingsVisible;
                    field("Total Savings Amount"; Rec."Total Savings Amount")
                    {
                        ApplicationArea = All;
                    }
                    field("Loan Savings Ratio"; Rec."Loan Savings Ratio")
                    {
                        ApplicationArea = All;
                    }
                    field("Max. Eligible Amount-Savings"; Rec."Max. Eligible Amount-Savings")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Shares)
                {
                    Caption = '';
                    Visible = IsSharesVisible;
                    field("Total Shares Amount"; Rec."Total Shares Amount")
                    {
                        ApplicationArea = All;
                    }
                    field("Loan Shares Ratio"; Rec."Loan Shares Ratio")
                    {
                        ApplicationArea = All;
                    }
                    field("Max. Eligible Amount-Shares"; Rec."Max. Eligible Amount-Shares")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Deposits)
                {
                    Caption = '';
                    Visible = IsDepositsVisible;
                    field("Total Deposits Amount"; Rec."Total Deposits Amount")
                    {
                        ApplicationArea = All;
                    }
                    field("Loan Deposits Ratio"; Rec."Loan Deposits Ratio")
                    {
                        ApplicationArea = All;
                    }
                    field("Max. Eligible Amount-Deposit"; Rec."Max. Eligible Amount-Deposit")
                    {
                        ApplicationArea = All;
                    }
                }

                field("Total Outstanding Loans"; Rec."Total Outstanding Loans")
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    Editable = Rec.Status = 0;
                    ApplicationArea = All;
                }
                group(DisbursalDetails)
                {
                    Caption = '';
                    Visible = Rec.Status = 2;
                    field("Disbursal Date"; Rec."Disbursal Date")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
                field("Economic Sector"; Rec."Economic Sector")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = 0;
                    ShowMandatory = true;
                }
                field("Economic Sector Category"; Rec."Economic Sector Category")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = 0;
                    ShowMandatory = true;
                }
                field("Economic Sector Sub-Category"; Rec."Economic Sector Sub-Category")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = 0;
                    ShowMandatory = true;
                }
                field("No. of Guarantors"; Rec."No. of Guarantors")
                {
                    ApplicationArea = All;
                }
                field("Total Guaranteed Amount"; Rec."Total Guaranteed Amount")
                {
                    ApplicationArea = All;
                }
                field("No. of Collaterals"; Rec."No. of Collaterals")
                {
                    ApplicationArea = All;
                }
                field("Total Collateral Amount"; Rec."Total Collateral Amount")
                {
                    ApplicationArea = All;
                }
                group(Approved)
                {
                    Caption = '';
                    Visible = Rec.Status = 1;
                    field("Approved Amount"; Rec."Approved Amount")
                    {
                        ApplicationArea = All;
                    }
                    field(Remarks; Rec.Remarks)
                    {
                        ApplicationArea = All;
                    }
                }

                group(RefinanceInfo)
                {
                    Caption = '';
                    Visible = Rec."Top-up" = TRUE;
                    field("No. of Loans Refinanced"; Rec."No. of Loans Refinanced")
                    {
                        ApplicationArea = All;
                    }
                    field("Total Refinanced Amount"; Rec."Total Refinanced Amount")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Next Due Date"; Rec."Next Due Date")
                {
                    ApplicationArea = All;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group("Salary Analysis")
            {
                Caption = 'Salary Analysis';
                Visible = IsSalaryAnalysisVisible;
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = All;
                }
                field("Total Deduction Amount"; Rec."Total Deduction Amount")
                {
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = All;
                }
                group(Payroll)
                {
                    Caption = '';
                    Visible = Rec."Member Category" = 0;
                    field("Payroll No."; Rec."Payroll No.")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
            }
            group("Payout Analysis")
            {
                Caption = 'Payout Analysis';
                Visible = IsPayoutAnalysisVisible;
                field("No. of KG"; Rec."No. of KG")
                {
                    ApplicationArea = All;
                }
                field("Rate per KG"; Rec."Rate per KG")
                {
                    ApplicationArea = All;
                }
                field("View Payout History"; Rec."View Payout History")
                {
                    ApplicationArea = All;
                }
                field("Total Payout Amount"; Rec."Total Payout Amount")
                {
                    ApplicationArea = All;
                }
            }

            group(Pause)
            {
                Caption = 'Pause Loan Recivables';
                Visible = Rec."Posted" = TRUE;
                group(PauseInt)
                {
                    Caption = 'Pause Interest';
                    field("Pause Loan Interest"; Rec."Pause Loan Interest")
                    {
                        ApplicationArea = All;
                    }
                    field("Int Paused By"; Rec."Int Paused By")
                    {
                        Caption = 'Interest Paused By';
                        ApplicationArea = All;
                    }
                    field("Int Paused Date"; Rec."Int Paused Date")
                    {
                        Caption = 'Interest Paused Date';
                        ApplicationArea = All;
                    }
                    field("Int Paused Time"; Rec."Int Paused Time")
                    {
                        Caption = 'Interest Paused Time';
                        ApplicationArea = All;
                    }
                    field("Int Paused By Host IP"; Rec."Int Paused By Host IP")
                    {
                        Caption = 'Interest Paused By Host IP';
                        ApplicationArea = All;
                    }
                    field("Int Paused By Host MAC"; Rec."Int Paused By Host MAC")
                    {
                        Caption = 'Interest Paused By Host MAC';
                        ApplicationArea = All;
                    }
                    field("Int Paused By Host Name"; Rec."Int Paused By Host Name")
                    {
                        Caption = 'Interest Paused By Host Name';
                        ApplicationArea = All;
                    }
                }
                group(PausePen)
                {
                    Caption = 'Pause Penalty';
                    field("Pause Loan Penalty"; Rec."Pause Loan Penalty")
                    {
                        ApplicationArea = All;
                    }
                    field("Pen Paused By"; Rec."Pen Paused By")
                    {
                        Caption = 'Penalty Paused By';
                        ApplicationArea = All;
                    }
                    field("Pen Paused Date"; Rec."Pen Paused Date")
                    {
                        Caption = 'Penalty Paused Date';
                        ApplicationArea = All;
                    }
                    field("Pen Paused Time"; Rec."Pen Paused Time")
                    {
                        Caption = 'Penalty Paused Time';
                        ApplicationArea = All;
                    }
                    field("Pen Paused By Host IP"; Rec."Pen Paused By Host IP")
                    {
                        Caption = 'Penalty Paused By Host IP';
                        ApplicationArea = All;
                    }
                    field("Pen Paused By Host MAC"; Rec."Pen Paused By Host MAC")
                    {
                        Caption = 'Penalty Paused By Host MAC';
                        ApplicationArea = All;
                    }
                    field("Pen Paused By Host Name"; Rec."Pen Paused By Host Name")
                    {
                        Caption = 'Penalty Paused By Host Name';
                        ApplicationArea = All;
                    }
                }
            }
            group(CreatedBy)
            {
                Caption = 'Created By';
                Visible = Rec."Status" = 0;
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
                field("Created By Host Name"; Rec."Created By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Created By Host IP"; Rec."Created By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Created By Host MAC"; Rec."Created By Host MAC")
                {
                    ApplicationArea = All;
                }
            }
            group(AppraisedBy)
            {
                Caption = 'Appraised By';
                Visible = Rec."Status" = 1;
                field("Appraised By"; Rec."Appraised By")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Time"; Rec."Appraisal Time")
                {
                    ApplicationArea = All;
                }
                field("Appraised By Host Name"; Rec."Appraised By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Appraised By Host IP"; Rec."Appraised By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Appraised By Host MAC"; Rec."Appraised By Host MAC")
                {
                    ApplicationArea = All;
                }
            }
            group(ApprovedBy)
            {
                Caption = 'Approved By';
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
                field("Approved By Host Name"; Rec."Approved By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Approved By Host IP"; Rec."Approved By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Approved By Host MAC"; Rec."Approved By Host MAC")
                {
                    ApplicationArea = All;
                }
            }
            group(Adjustment)
            {
                Caption = 'Repayment Adjustment';
                Visible = Rec."Posted" = TRUE;
                field("Repayment Adjustment Amount"; Rec."Repayment Adjustment Amount")
                {
                    ApplicationArea = All;
                }
                field("Repayment Adjustment"; Rec."Repayment Adjustment")
                {
                    ApplicationArea = All;
                }
            }

            group(DisbursedBy)
            {
                Caption = 'Disbursed By';
                Visible = Rec."Posted" = TRUE;
                field("Disbursed By"; Rec."Disbursed By")
                {
                    ApplicationArea = All;
                }
                field("Disbursal Time"; Rec."Disbursal Time")
                {
                    ApplicationArea = All;
                }
                field("Disbursed By Host Name"; Rec."Disbursed By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Disbursed By Host IP"; Rec."Disbursed By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Disbursed By Host MAC"; Rec."Disbursed By Host MAC")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Importance = Additional;

                }
            }
        }
        area(factboxes)
        {
            part(Page; "Loan Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");

            }
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
        area(navigation)
        {
            action("Loan Guarantors")
            {
                ApplicationArea = All;
                Image = CoupledUsers;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                begin
                    LoanGuarantor.FILTERGROUP(10);
                    LoanGuarantor.SETRANGE("Loan No.", Rec."No.");
                    LoanGuarantor.FILTERGROUP(0);
                    PAGE.RUN(50210, LoanGuarantor);
                end;
            }
            action("Loan Collaterals")
            {
                ApplicationArea = All;
                Image = Lock;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    LoanCollateral.FILTERGROUP(10);
                    LoanCollateral.SETRANGE("Loan No.", Rec."No.");
                    LoanCollateral.FILTERGROUP(0);
                    PAGE.RUN(50209, LoanCollateral);
                end;
            }
            action("LoanRefinancingEntry")
            {
                Caption = 'Loans to Refinance';
                ApplicationArea = All;
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = Rec."Top-up";

                trigger OnAction()
                var
                begin
                    LoanRefinancingEntry.FILTERGROUP(10);
                    LoanRefinancingEntry.SETRANGE("Loan No.", Rec."No.");
                    LoanRefinancingEntry.FILTERGROUP(0);
                    PAGE.RUN(50211, LoanRefinancingEntry);
                end;
            }
        }
        area(processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';
                Visible = IsVisibleSendApprovalRequest;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    Rec.TESTFIELD("Requested Amount");
                    Rec.TESTFIELD("Economic Sector");
                    Rec.TESTFIELD("Economic Sector Category");
                    Rec.TESTFIELD("Economic Sector Sub-Category");
                    // ValidateAttachment;

                    IF LoanProductType.GET(Rec."Loan Product Type") THEN BEGIN
                        IF ((LoanProductType."Security Type" = LoanProductType."Security Type"::"Guarantors Only") OR
                           (LoanProductType."Security Type" = LoanProductType."Security Type"::Both)) THEN BEGIN
                            IF NOT Rec.GetGuarantors THEN
                                ERROR(Error000)
                            ELSE BEGIN
                                Rec.CALCFIELDS("No. of Guarantors");
                                IF Rec."No. of Guarantors" < Rec.CheckMinimumGuarantors THEN
                                    ERROR(Error001, Rec.CheckMinimumGuarantors);
                                IF Rec.GetTotalSecurityAmount + Rec."Max. Eligible Amount-Deposit" < Rec."Requested Amount" THEN
                                    ERROR(Error004, Rec."No.");
                            END;
                        END;
                        IF ((LoanProductType."Security Type" = LoanProductType."Security Type"::"Collaterals Only") OR
                           (LoanProductType."Security Type" = LoanProductType."Security Type"::Both)) THEN BEGIN
                            IF NOT Rec.GetSecurities THEN
                                ERROR(Error005);
                        END;
                        IF LoanProductType."Security Type" = LoanProductType."Security Type"::Either THEN BEGIN
                            IF Rec.GetTotalSecurityAmount + Rec."Max. Eligible Amount-Deposit" < Rec."Requested Amount" THEN
                                ERROR(Error004, Rec."No.");
                        END;

                        IF Rec."Top-up" THEN BEGIN
                            Rec.CALCFIELDS("No. of Loans Refinanced", "Total Refinanced Amount");
                            Rec.TESTFIELD("No. of Loans Refinanced");
                            Rec.TESTFIELD("Total Refinanced Amount");
                            if Rec."Total Refinanced Amount" > Rec."Requested Amount" then
                                Error(RefinancedAmountExceedsReqAmountErr, Rec.FieldCaption("Total Refinanced Amount"), Rec.FieldCaption("Requested Amount"));
                        END;
                    END;
                    IF ApprovalsMgmt.CheckLoanApplicationApprovalPossible(Rec) THEN begin
                        ApprovalsMgmt.OnSendLoanApplicationForApproval(Rec);
                        BOSAManagement.SendNotification(RecRef);
                    end;
                    CurrPage.Close();
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = IsVisibleCancelApprovalRequest;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    ApprovalsMgmt.OnCancelLoanApplicationApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
                    CurrPage.Close();
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';
                Visible = IsApproveVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TESTFIELD("Approved Amount");
                    Rec.TESTFIELD(Remarks);

                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                        BOSAManagement.SendNotification(RecRef);
                    end;
                    CurrPage.CLOSE;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';
                Visible = IsRejectVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);

                    CurrPage.CLOSE;
                end;
            }

            action(Return)
            {
                ApplicationArea = All;
                Caption = 'ReOpen Document';
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Return to the initial approval stage.';
                Visible = Rec.Posted = false;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    IF Rec.Status = Rec.Status::"Pending Approval" then
                        Rec.Status := Rec.Status::New;
                    IF Rec.Status = Rec.Status::Approved then
                        Rec.Status := Rec.Status::New;
                    Rec.Modify();
                    CurrPage.Close();
                end;
            }
            action(Delegate)
            {
                ApplicationArea = All;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = IsDelegateVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TESTFIELD("Approved Amount");
                    Rec.TESTFIELD(Remarks);

                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                    CurrPage.CLOSE;
                end;
            }
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsPostVisible;
                ApplicationArea = All;
                ToolTip = 'Post loan and create new loan account';

                trigger OnAction()
                var
                    RecRef: RecordRef;
                begin
                    Rec.TESTFIELD("Disbursal Date");
                    if Confirm(Text000, true) then begin
                        BOSAManagement.PostLoan(Rec);
                        RecRef.GetTable(Rec);
                        BOSAManagement.SendNotification(RecRef);
                        CurrPage.Close();
                        Exit;
                    end else
                        Exit;
                end;

            }
            action(Reverse)
            {
                ApplicationArea = All;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Category8;
                Visible = Rec.Posted = true;
                ToolTip = 'Reverse posted loan';
                trigger OnAction();
                var

                begin
                    if Confirm(ReverseLoanConfirmMsg, true, Rec."No.") then
                        BOSAManagement.ReverseLoan(Rec);
                    CurrPage.Close();
                    exit;
                end;
            }

            action("Notify Guarantors")
            {
                ApplicationArea = All;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                Visible = Rec."No. of Guarantors" > 0;
                ToolTip = 'Send notification to guarantors';
                trigger OnAction()
                begin
                    if Confirm(NotifyGuarantorsConfirmMsg, true, Rec."No.") then begin
                        RecRef.GetTable(Rec);
                        BOSAManagement.SendNotification(RecRef);
                        Message('SMS Entries created');
                    end;
                end;
            }


        }
        area(Reporting)
        {
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
                begin

                    IF not Rec.Posted THEN BEGIN
                        Rec.TESTFIELD("Requested Amount");
                        BOSAManagement.CreateRepaymentSchedule(Rec."No.", Rec."Requested Amount");
                        COMMIT;
                    END else begin
                        BOSAManagement.CreateRepaymentSchedule(Rec."No.", Rec."Approved Amount");
                        COMMIT;
                        //if "Loan Restructured" = true then
                        //BOSAManagement.CreateRepaymentScheduleRestructure("No.", "Approved Amount");
                    END;

                    LoanApplication.GET(Rec."No.");
                    LoanApplication.SETRECFILTER;
                    REPORT.RUN(REPORT::"Loan Repament Schedule", TRUE, FALSE, LoanApplication);
                end;
            }
            action("Loan Appraisal Report")
            {
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Preview loan appraisal report';
                trigger OnAction()
                begin
                    Rec.TESTFIELD("Repayment Period");
                    Rec.TESTFIELD("Requested Amount");
                    BOSAManagement.CreateRepaymentSchedule(Rec."No.", Rec."Requested Amount");

                    COMMIT;
                    LoanApplication.GET(Rec."No.");
                    LoanApplication.SETRECFILTER;
                    REPORT.RUN(REPORT::"Loan Appraisal Report", TRUE, FALSE, LoanApplication);
                end;
            }
            action("Loan Voucher")
            {
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = Rec.Posted = true;
                ToolTip = 'Preview loan voucher';
                trigger OnAction()
                begin

                    LoanApplication.GET(Rec."No.");
                    LoanApplication.SETRECFILTER;
                    REPORT.RUN(REPORT::"Loan Voucher", TRUE, FALSE, LoanApplication);
                end;
            }
            action("Loan Offer Letter")
            {
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = Rec.Status = 2;
                ToolTip = 'Preview loan Offer Letter';
                trigger OnAction()
                begin
                    LoanApplication.GET(Rec."No.");
                    LoanApplication.SETRECFILTER;
                    REPORT.RUN(REPORT::"Loan Offer Letter", TRUE, FALSE, LoanApplication);
                end;
            }
            action("Loan Demand Letter")
            {
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = Rec.Posted = true;
                ToolTip = 'Preview Loan Demand Letter';
                trigger OnAction()
                begin
                    LoanApplication.GET(Rec."No.");
                    LoanApplication.SETRECFILTER;
                    REPORT.RUN(REPORT::"Loan Demand Letter", TRUE, FALSE, LoanApplication);
                end;
            }
            action(LoanStatement)
            {
                Caption = 'Loan Statement';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Preview loan statement';
                trigger OnAction()
                begin
                    LoanApplication.FILTERGROUP(10);
                    LoanApplication.SETRANGE("Member No.", Rec."Member No.");
                    LoanApplication.SetRange("No.", Rec."No.");
                    LoanApplication.FILTERGROUP(0);
                    Report.RUN(50081, true, false, LoanApplication);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
    end;

    trigger OnOpenPage()
    var
        GlobalM: Codeunit "Global Management";
    begin
        PageVisibility;
        /// PageEditable;
        ValidateLoanProduct;
        /*CalcFields("Outstanding Balance");
        if "Outstanding Balance" > 0 then begin
            GlobalM.CalculateLoanArrearsAndOverpayment("No.", 0D, Today, ArrearsAmount[1], ArrearsAmount[2], ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
            "Principal Arrears" := ArrearsAmount[1];
            "Interest Arrears" := ArrearsAmount[2];
            "Ledger Fee Arrears" := ArrearsAmount[3];
            "Penalty Arrears" := ArrearsAmount[4];
            "Principal Overpayment" := OverpaymentAmount[1];
            "Interest Overpayment" := OverpaymentAmount[2];
            "Total Arrears" := ArrearsAmount[1] + ArrearsAmount[2] + ArrearsAmount[3] + ArrearsAmount[4];
            Modify();
        end;*/
    end;


    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleSendApprovalRequest := TRUE;
            IsVisibleCancelApprovalRequest := TRUE;
        END ELSE BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
        END;

        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsApproveVisible := TRUE;
            IsRejectVisible := TRUE;
            IsDelegateVisible := TRUE;
        END ELSE BEGIN
            IsApproveVisible := FALSE;
            IsRejectVisible := FALSE;
            IsDelegateVisible := FALSE;
        END;

        IF Rec.Status = Rec.Status::Approved THEN
            IsPostVisible := TRUE
        ELSE
            IsPostVisible := FALSE;
        IF Rec.Posted THEN
            IsPostVisible := FALSE
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::Approved THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
    end;

    local procedure ValidateLoanProduct()
    begin
        IF LoanProductType.GET(Rec."Loan Product Type") THEN BEGIN
            IF LoanProductType."Based on Savings" THEN
                IsSavingsVisible := TRUE
            ELSE
                IsSavingsVisible := FALSE;

            IF LoanProductType."Based on Shares" THEN
                IsSharesVisible := TRUE
            ELSE
                IsSharesVisible := FALSE;

            IF LoanProductType."Based on Deposits" THEN
                IsDepositsVisible := TRUE
            ELSE
                IsDepositsVisible := FALSE;

            // IF LoanProductType."Mode of Disbursement" = LoanProductType."Mode of Disbursement"::"FOSA Account" THEN
            //     IsFOSAVisible := TRUE
            // ELSE
            //     IsFOSAVisible := FALSE;

            // IF LoanProductType."Mode of Disbursement" = LoanProductType."Mode of Disbursement"::"Mobile Banking" THEN
            //     IsMobileVisible := TRUE
            // ELSE
            //     IsMobileVisible := FALSE;


        END;
    end;

    var
        LoanGuarantor: Record "Loan Guarantor";
        LoanCollateral: Record "Loan Collateral";
        LoanRefinancingEntry: Record "Loan Refinancing Entry";
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        Error000: Label 'Guarantors are required';
        Error001: Label 'You must have at least %1 guarantors';
        Error002: Label 'Total guaranteed amount cannot be zero!';
        Error003: Label 'Total security amount cannot be zero!';
        Error004: Label 'Loan No. %1 is not fully guaranteed.';
        Error005: Label 'Collaterals are required';
        LoanProductType: Record "Loan Product Type";
        IsSavingsVisible: Boolean;
        IsSharesVisible: Boolean;
        IsDepositsVisible: Boolean;

        ArrearsAmount: array[4] of Decimal;
        OverpaymentAmount: array[4] of Decimal;
        IsApproveVisible: Boolean;
        IsRejectVisible: Boolean;
        IsDelegateVisible: Boolean;
        IsPostVisible: Boolean;
        IsMobileVisible: Boolean;
        IsFOSAVisible: Boolean;
        Text000: Label 'Do you want to disburse this Loan?';
        IsSalaryAnalysisVisible: Boolean;
        IsPayoutAnalysisVisible: Boolean;
        LoanApplication: Record "Loan Application";
        ReverseLoanConfirmMsg: Label 'Do you want to reverse loan %1?';
        BOSAManagement: Codeunit "BOSA Management";
        FieldEditable: Boolean;
        NotifyGuarantorsConfirmMsg: Label 'Do you want to notify guarantors for loan %1?';
        RecRef: RecordRef;
        RefinancedAmountExceedsReqAmountErr: Label '%1 exceeds the %2';

}

