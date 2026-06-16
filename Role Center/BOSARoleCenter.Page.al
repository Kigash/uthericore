page 50346 "BOSA RoleCenter"
{
    PageType = RoleCenter;
    Caption = 'BOSA Role Center';
    layout
    {
        area(RoleCenter)
        {

            part(Part1; "BOSA RoleCenter Headline")
            {
                ApplicationArea = All;
            }

            part(Part2; "BOSA Activities")
            {
                Caption = 'BOSA';
                ApplicationArea = All;
            }
            part(Control1; "Branch Analysis-LProduct Chart")
            {
                AccessByPermission = TableData "Sales Shipment Header" = R;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control2; "Classification Summary Chart")
            {
                AccessByPermission = TableData "Sales Shipment Header" = R;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

        }
    }

    actions
    {
        area(Sections)
        {
            group(MemberApplication)
            {
                Caption = 'Member Application';

                action("New Member Applications")
                {
                    RunObject = Page "Member Application List-New";
                    ApplicationArea = All;
                }
                action("Pending Member Applications")
                {
                    RunObject = Page "Member Appl. List-Pending";
                    ApplicationArea = All;
                }
                action("Approved Member Applications")
                {
                    RunObject = Page "Member Appl. List-Approved";
                    ApplicationArea = All;
                }
            }
            group(LoanApplication)
            {
                Caption = 'Loan Application';

                action("New Loan Application")
                {
                    RunObject = Page "Loan Application List-New";
                    ApplicationArea = All;
                }
                action("Loans Pending Appraisal")
                {
                    RunObject = Page "Loan Appl. List-Pending Apprsl";
                    ApplicationArea = All;
                }
                action("Loans Pending Disbursal")
                {
                    RunObject = Page "Loan Appl. List-Pending Dbsl";
                    ApplicationArea = All;
                }
                action("Rejected Loans")
                {
                    RunObject = Page "Loans Appl. List-Rejected";
                    ApplicationArea = All;
                }
                action("Posted Loans")
                {
                    RunObject = Page "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
            }

            group(LoanClassification)
            {
                Caption = 'Loan Classification';
                action("Classification Entries")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Classification Entries";
                }
                action("Generate Classification")
                {
                    ApplicationArea = All;
                    RunObject = report "Generate Loan Classification";
                }
            }
            group(FundTransfer)
            {
                Caption = 'Fund Transfer';
                action("New Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-New";

                }
                action("Pending Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Pending";

                }
                action("Approved Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Approved";

                }
                action("Rejected Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Rejected";

                }
                action("Posted Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Posted";

                }
            }
            group(LoanRescheduling)
            {
                Caption = 'Loan Rescheduling';
                action("New Loan Rescheduling")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Rescheduling List-New";
                }
                action("Pending Loan Rescheduling")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Rescheduling List-Pending";
                }
                action("Approved Loan Rescheduling")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Resched. List-Approved";
                }
                action("Rejected Loan Rescheduling")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Resched. List-Rejected";
                }
            }
            group(LoanRestructuring)
            {
                Caption = 'Loan Restructuring';
                action("New Loan Restructuring")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Restruct List-New";
                }
                action("Pending Loan Restructuring")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Restruct List-Pending";
                }
                action("Approved Loan Restructuring")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Restruct List-Approved";
                }
                action("Rejected Loan Restructuring")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Restruct List-Rejected";
                }
            }
            group(LoanBaancing)
            {
                Caption = 'Loan Balancing';
                action("New Loan Balancing")
                {
                    ApplicationArea = All;
                    RunObject = page "LoanBalanc List-New";
                }
                action("Posted Loan Balancing")
                {
                    ApplicationArea = All;
                    RunObject = page "LoanBalanc List-Approved";
                }
            }
            group(LoanNotification)
            {
                Caption = 'Loan Notification';
                Visible = false;
                action("Notification Entries")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Notification Entries";
                }
            }
            group(GuarantorSubstitution)
            {
                Caption = 'Guarantor Substitution';
                action("New Guarantor Substitution")
                {
                    ApplicationArea = All;
                    RunObject = page "Guarantor Subst. List-New";
                }
                action("Pending Guarantor Substitution")
                {
                    ApplicationArea = All;
                    RunObject = page "Guarantor Sub. List-Pending";
                }
                action("Approved Guarantor Substitution")
                {
                    ApplicationArea = All;
                    RunObject = page "Guarantor Subst. List-Approved";
                }
                action("Rejected Guarantor Substitution")
                {
                    ApplicationArea = All;
                    RunObject = page "Guarantor Sub. List-Rejected";
                }
                action("GuarantorSubstitutionEntries")
                {
                    Caption = 'Guarantor Substitution Entries';
                    ApplicationArea = All;
                    RunObject = page "Guarantor Substitution Entries";
                }
            }


            group(LoanWriteofff)
            {
                Caption = 'Loan Writeoff';
                action("New Loan Writeofff")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Writeoff List-New";
                }
                action("Pending Loan Writeoff")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Writeoff List-Pending";
                }
                action("Approved Loan Writeoff")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Writeoff List-Approved";
                }
                action("Rejected Loan Writeoff")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Writeoff List-Rejected";
                }
                action("Posted Loan Writeoff")
                {
                    ApplicationArea = All;
                    RunObject = page "Loan Writeoff List-Posted";
                }
            }

            group(ExitManagement)
            {
                Caption = 'Exit Management';
                group(ExitProcessing)
                {
                    Caption = 'Exit Processing';
                    action("New Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-New";

                    }
                    action("Pending Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Pending";

                    }
                    action("Approved Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Approved";

                    }
                    action("Posted Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Posted";

                    }
                    action("Rejected Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Rejected";

                    }
                }
            }
            group(SavingsWithManagement)
            {
                Caption = 'Savings Withdrawal';
                action("New Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "Member Savings With List-New";

                }
                action("Pending Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "MemberSavings WithList-Pending";

                }
                action("Approved Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "Member Savings With-Approved";

                }
                action("Posted Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "MemberSavings WithList-Posted";

                }
                action("Rejected Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "MemberSavings WithList-Rejectd";

                }
            }
            group(ArchiveManagement)
            {
                Caption = 'Archive Management';
                group(ArchiveProcessing)
                {
                    Caption = 'Archive Processing';
                    action("New Member Archive")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-New";

                    }
                    action("Pending Member Archive")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-Pending";

                    }
                    action("Approved Member Archive")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-Approved";

                    }
                    action("Archived Members")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-Posted";

                    }
                }
            }
            group(DividendProcessing)
            {
                Caption = 'Dividend Processing';
                action("New Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-New";
                }
                action("Posted Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-Posted";
                }
                action("Dividend Setup")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividend Setup";
                }

            }
            group(DefaulterManagement)
            {
                Caption = 'Defaulter Management';
                Visible = true;
                group(DefaulterPeriodicActivities)
                {
                    Caption = 'Periodic Activities';
                    action("Send Defaulter Notice")
                    {
                        ApplicationArea = All;
                        RunObject = report "Send Defaulter Notice";
                    }
                    action("Recover Loan From Guarantor Deposits")
                    {
                        ApplicationArea = All;
                        RunObject = report RecoverLoanFromGuarantor;
                    }
                    action("Attach Loan to Guarantor")
                    {
                        ApplicationArea = All;
                        RunObject = report "Attach Loan to Guarantor";
                    }
                    action("Reverse Attached Loan")
                    {
                        ApplicationArea = All;
                        RunObject = report "Reverse Attached Loan";
                    }
                }
            }
            group(PeriodicActivities)
            {
                Caption = 'Periodic Activities';
                action(EndOfMonth)
                {
                    Caption = 'Run End Of Month';
                    ApplicationArea = All;
                    RunObject = report "Run End Of Month";
                }
            }
            group(Notification)
            {
                action("SMS Entries")
                {
                    ApplicationArea = All;
                    RunObject = page "SMS Entries";
                }
            }
            group(MobileChargeSetup)
            {
                Caption = 'Mobile Charge GL Setup';
                action(MobileChargeGLSetupBOSA)
                {
                    Caption = 'Mobile Charge GL Setup';
                    RunObject = page "Mobile Charge GL Setup List";
                    ApplicationArea = All;
                }
            }
            group(BOSAReports)
            {
                Caption = 'Reports';
                action("Loan Repayment Schedule")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Repament Schedule";
                }
                action("Branch Performance")
                {
                    ApplicationArea = All;
                    RunObject = report "Branch Performance";
                }
                action("Branch Portfolio")
                {
                    ApplicationArea = All;
                    RunObject = report "Branch Portfolio Report";
                }
                action("Loan Securities")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Securities";
                }
                action("Loan Guarantors")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Guarantors";
                }
                action("Loan Provisioning")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Provisioning Report";
                }
                action("Loan Classification")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Classification Report";
                }
                action("Loan Listing")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Listing Report";
                }
                action("Disbursed Loans")
                {
                    ApplicationArea = All;
                    RunObject = report "Disbursed Loans";
                }
                action("Defaulted Loans")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Defaulters";
                }
                action("Classification Summary")
                {
                    ApplicationArea = All;
                    RunObject = report "Classification Summary";
                }
                action("Classification Summary-Per Branch")
                {
                    ApplicationArea = All;
                    RunObject = report "Classification Summary- Branch";
                }
                action("Loan Arrears")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Arrears";
                }

                action("Loan Status")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Status";
                }
                action("Loan Statement")
                {
                    ApplicationArea = All;
                    RunObject = report "Member Loan Statement";
                }
                action("Member Listing")
                {
                    ApplicationArea = All;
                    RunObject = report "Member Listing Report";
                }
                action("Member Statement")
                {
                    ApplicationArea = All;
                    RunObject = report "Member Statement";
                }
                action("Member Statement-Combined")
                {
                    ApplicationArea = All;
                    RunObject = report "Member Statement-Combined";
                }
                action("Loan Securities2")
                {
                    ApplicationArea = All;
                    RunObject = report "Loan Securities";
                }
                action("CRB Report")
                {
                    ApplicationArea = All;
                    RunObject = report "CRB Report 2";
                }
                action("Demand Letter")
                {
                    ApplicationArea = All;
                    RunObject = report "Demand Letter";
                }
                action("Account Types Listing")
                {
                    ApplicationArea = All;
                    RunObject = report "Account Types Listing";
                }
                action("Share Certificate")
                {
                    ApplicationArea = All;
                    RunObject = report "Share Certificate";
                }
                action("Accounts Movement")
                {
                    ApplicationArea = All;
                    RunObject = report "Accounts Movement";
                }
                action("Rescheduled Loans")
                {
                    ApplicationArea = All;
                    RunObject = report "Rescheduled Loans";
                }

                action("Guarantor Substitution Entries")
                {
                    ApplicationArea = All;
                    RunObject = report "Guarantor Substitution Entries";
                }
                action("Dividend Report")
                {
                    ApplicationArea = All;
                    RunObject = report "Dividends Report";
                }
                action("Exit Requests")
                {
                    ApplicationArea = All;
                    RunObject = report "Exit Request";
                }
                action("Written off Loans")
                {
                    ApplicationArea = All;
                    RunObject = report "Written off Loans";
                }
                action("Members & Accounts Summary per Branch")
                {
                    ApplicationArea = All;
                    RunObject = report "Members & Accounts Summary";
                }

            }
        }
        area(Embedding)
        {

            action(MembersIndividual)
            {
                Caption = 'Individual Members';
                RunObject = Page "Member List";
                ApplicationArea = All;

            }
            action(MembersGroup)
            {
                Caption = 'Groups';
                RunObject = Page MemberListGroup;
                ApplicationArea = All;

            }
            action(MembersJoint)
            {
                Caption = 'Joint Members';
                RunObject = Page "Member List Joint";
                ApplicationArea = All;

            }
            action(MembersJunior)
            {
                Caption = 'Junior Members';
                RunObject = Page MemberListJunior;
                ApplicationArea = All;

            }
            action(MembersStaff)
            {
                Caption = 'Staff';
                RunObject = Page MemberListStaff;
                ApplicationArea = All;

            }
            action(MembersBoard)
            {
                Caption = 'Board';
                RunObject = Page MemberListBoard;
                ApplicationArea = All;

            }
            action(RequestApproval)
            {
                Caption = 'Requests To Approve';
                RunObject = Page "Requests to Approve";
                ApplicationArea = All;

            }

            action(MembersSDAccounts)
            {
                Caption = 'Savings Accounts';
                RunObject = Page "Member S/Dep. Account List";
                ApplicationArea = All;

            }
            action(MemberLoanAccount)
            {
                Caption = 'Loan Accounts';
                RunObject = Page "Member Loan Account List";
                ApplicationArea = All;

            }
            action(AccountTypes)
            {
                Caption = 'Account Types';
                RunObject = Page "Account Type List";
                ApplicationArea = All;

            }
            action(SMSEntries)
            {
                Caption = 'SMS Entries';
                RunObject = Page "SMS Entries";
                ApplicationArea = All;
            }
        }
        area(Processing)
        {
            group(PeriodActivities)
            {
                Caption = 'Periodic Activities';
                Visible = false;
                action(CapitalizeInterest)
                {
                    Caption = 'Run Monthly Interest';
                    RunObject = report "Run Monthly Interest";
                    ApplicationArea = All;
                }
                action(CapitalizePenalty)
                {
                    Caption = 'Run Monthly Penalty';
                    RunObject = report "Run Monthly Penalty";
                    ApplicationArea = All;
                }
            }
            group("SASRA Reports")
            {
                action(LoanSecurities2)
                {
                    Caption = 'Loan Securities';
                    Image = "Report";
                    RunObject = Report "Loan Securities";
                    ApplicationArea = All;
                }
                action(BranchPortfolio2)
                {
                    Caption = 'Branch Portfolio';
                    Image = "Report";
                    RunObject = Report "Branch Portfolio Report";
                    ApplicationArea = All;
                }

                action(LiquidityStatementReturn)
                {
                    Caption = 'Liquidity Statement Return';
                    Image = "Report";
                    RunObject = Report "Liquidity Statement Return";
                    ApplicationArea = All;
                }
                action(StatementDepositReturn)
                {
                    Caption = 'Statement of Deposit Return';
                    Image = "Report";
                    RunObject = Report "Statement of Deposit Return";
                    ApplicationArea = All;
                }
                action(RiskClassificationofAssetsProvisioning)
                {
                    Caption = 'Risk Classification of Assets and Provisioning';
                    Image = "Report";
                    RunObject = Report "Risk Class. of Assets Prov.";
                    ApplicationArea = All;
                }
                action(ReturnOnInvestment)
                {
                    Caption = 'Return On Investment';
                    Image = "Report";
                    RunObject = Report "Return On Investment";
                    ApplicationArea = All;
                }
                action(StatementComprehensiveIncome)
                {
                    Caption = 'Statement of Comprehensive Income';
                    Image = "Report";
                    RunObject = Report "Statement of Compre. Income";
                    ApplicationArea = All;
                }
                action(StatementFinancialPosition)
                {
                    Caption = 'Statement of Financial Position';
                    Image = "Report";
                    RunObject = Report "Statement of Fin. Position";
                    ApplicationArea = All;
                }
                action(StatementOtherDisclosures)
                {
                    Caption = 'Statement of Other Disclosures';
                    Image = "Report";
                    RunObject = Report "Statemnt of Other Disclosures";
                    ApplicationArea = All;
                }
                action(CapitalAdequacyReturn)
                {
                    Caption = 'Capital Adequacy Return';
                    Image = "Report";
                    RunObject = Report "Capital Adequacy Return";
                    ApplicationArea = All;
                }
                action(InsiderLendingPerformanceReturn)
                {
                    Caption = 'Insider Lending and Performance Return';
                    Image = "Report";
                    RunObject = Report "Insider Lending Perfom Return";
                    ApplicationArea = All;
                }
                action(SectoralLendingLoanClassificationReturn)
                {
                    Caption = 'Sectoral Lending Loan Classification Return';
                    Image = "Report";
                    RunObject = Report "Sectoral Lending Report";
                    ApplicationArea = All;
                }
            }
        }
        area(Creation)
        {
            action(NewMemberApplication)
            {
                Caption = 'New Member Application';
                Image = NewInvoice;
                RunObject = Page "Member Application Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewLoanApplication)
            {
                Caption = 'New Loan Application';
                RunObject = page "Loan Application Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewFundTransfer)
            {
                Caption = 'New Fund Transfer';
                RunObject = page "Fund Transfer";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewLoanRescheduling)
            {
                Caption = 'New Loan Rescheduling';
                RunObject = page "Loan Rescheduling";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewDividend)
            {
                Caption = 'New Dividend';
                RunObject = page Dividend;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewGuarantorSubstitution)
            {
                Caption = 'New Guarantor Substitution';
                RunObject = page "Guarantor Substitution";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewLoanWriteoff)
            {
                Caption = 'New Loan Writeoff';
                RunObject = page "Loan Writeoff";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewExitRequest)
            {
                Caption = 'New Exit Request';
                RunObject = page "Member Exit";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(GenJournal)
            {
                Caption = 'General Journal';
                RunObject = Page "General Journal";
                ApplicationArea = All;
            }

        }
        area(Reporting)
        {
            action(MemberStatement)
            {
                Caption = 'Member Statement';
                Image = "Report";
                RunObject = Report "Member Statement";
                ApplicationArea = All;
            }
            action(LoanStatement)
            {
                Caption = 'Loan Statement';
                Image = "Report";
                RunObject = Report "Member Loan Statement";
                ApplicationArea = All;
            }
            action(MemberStatementCombined)
            {
                Caption = 'Member Statement-Combined';
                Image = "Report";
                RunObject = Report "Member Statement-Combined";
                ApplicationArea = All;
            }
            action(LoanRepaymentSchedule)
            {
                Caption = 'Loan Repayment Schedule';
                Image = "Report";
                RunObject = Report "Loan Repament Schedule";
                ApplicationArea = All;
            }
            action(LoanAppraisalReport)
            {
                Caption = 'Loan Appraisal Report';
                Image = "Report";
                RunObject = Report "Loan Appraisal Report";
                ApplicationArea = All;
            }
            action(Calculator)
            {
                Image = Calculate;
                Caption = 'Loan Calculator';
                RunObject = Report "Loan Calculator";
                ApplicationArea = All;
            }
            action(RunEndOfMonth)
            {
                Caption = 'Run End Of Month';
                ApplicationArea = All;
                RunObject = report "Run End Of Month";
            }
        }
    }
}
// Creates a profile that uses the Role Center
profile BOSAProfile
{
    ProfileDescription = 'BOSA Profile';
    RoleCenter = "BOSA RoleCenter";
    Caption = 'BOSA';
}

