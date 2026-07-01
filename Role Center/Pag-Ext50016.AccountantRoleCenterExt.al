pageextension 50016 "Accountant RoleCenter Ext" extends "Accountant Role Center"
{
    layout
    {

        modify(Control76)
        {
            Visible = false;
        }
        modify(Control99)
        {
            Visible = false;
        }
        modify(Control1902304208)
        {
            Visible = false;
        }
        modify("Intercompany Activities")
        {
            Visible = false;
        }
        modify("User Tasks Activities")
        {
            Visible = false;
        }
        modify("Job Queue Tasks Activities")
        {
            Visible = false;
        }
        modify("Emails")
        {
            Visible = false;
        }
        modify(ApprovalsActivities)
        {
            Visible = false;
        }
        modify(Control123)
        {
            Visible = false;
        }
        modify(Control1907692008)
        {
            Visible = false;
        }
        modify(Control103)
        {
            Visible = false;
        }
        modify(Control106)
        {
            Visible = false;
        }
        modify(Control9)
        {
            Visible = false;
        }
        modify(Control100)
        {
            Visible = false;
        }
        modify(Control108)
        {
            Visible = false;
        }
        modify(PowerBIEmbeddedReportPart)
        {
            Visible = false;
        }
        modify(Control1901377608)
        {
            Visible = false;
        }
        /*
        part(Control76; "Headline RC Accountant")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    part(Control99; "Finance Performance")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    part(Control1902304208; "Accountant Activities")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    part("Intercompany Activities"; "Intercompany Activities")
                    {
                        ApplicationArea = Intercompany;
                    }
                    part("User Tasks Activities"; "User Tasks Activities")
                    {
                        ApplicationArea = Suite;
                    }
                    part("Job Queue Tasks Activities"; "Job Queue Tasks Activities")
                    {
                        ApplicationArea = Suite;
                    }
                    part("Emails"; "Email Activities")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    part(ApprovalsActivities; "Approvals Activities")
                    {
                        ApplicationArea = Suite;
                    }
                    part(Control123; "Team Member Activities")
                    {
                        ApplicationArea = Suite;
                    }
                    part(Control1907692008; "My Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    part(Control103; "Trailing Sales Orders Chart")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    part(Control106; "My Job Queue")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    part(Control9; "Help And Chart Wrapper")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    part(Control100; "Cash Flow Forecast Chart")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    part(Control108; "Report Inbox Part")
                    {
                        AccessByPermission = TableData "Report Inbox" = IMD;
                        ApplicationArea = Basic, Suite;
                    }
                    part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    systempart(Control1901377608; MyNotes)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                */
        addfirst(RoleCenter)
        {
            part(Part1; "FOSA RoleCenter Headline")
            {
                ApplicationArea = All;
            }

            part(Part2; "FOSA Activities")
            {
                Caption = 'Members Analysis';
                ApplicationArea = All;
            }
            part(Part3; "BOSA Activities")
            {
                Caption = 'BOSA';
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        modify("Posted Documents")
        {
            Visible = false;
        }
        modify("Cash Flow")
        {
            Visible = false;
        }
        modify("Customers and Vendors")
        {
            Visible = false;
        }
        modify("VAT Reports")
        {
            Visible = false;
        }
        modify("Cost Accounting")
        {
            Visible = false;
        }
        modify("Run Consolidation")
        {
            Visible = false;
        }
        modify(History)
        {
            Visible = false;
        }
        modify(Payments)
        {
            Visible = false;
        }
        modify(Analysis)
        {
            Visible = false;
        }
        modify(Tasks)
        {
            Visible = false;
        }
        modify(Create)
        {
            Visible = false;
        }
        modify("Sales &Credit Memo")
        {
            Visible = false;
        }
        modify("P&urchase Credit Memo")
        {
            Visible = false;
        }
        modify("G/L Journal Entry")
        {
            Visible = false;
        }
        modify("Payment Journal Entry")
        {
            Visible = false;
        }
        modify(Action1020012)
        {
            Visible = false;
        }
        /*
     action("Sales &Credit Memo")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo';
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }
            action("P&urchase Credit Memo")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'P&urchase Credit Memo';
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase credit memo so you can manage returned items to a vendor.';
            }
            action("G/L Journal Entry")
            {
                AccessByPermission = TableData "G/L Entry" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'G/L Journal Entry';
                RunObject = Page "General Journal";
                ToolTip = 'Prepare to post any transaction to the company books.';
            }
            action("Payment Journal Entry")
            {
                AccessByPermission = TableData "Gen. Journal Batch" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal Entry';
                RunObject = Page "Payment Journal";
                ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
            }
            action(Action1020012)
            {
                AccessByPermission = TableData "Gen. Journal Template" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Deposit';
                RunObject = Codeunit "Open Deposit Page";
                RunPageMode = Create;
                ToolTip = 'Create a new bank deposit. ';
            }

        */
        addafter("Sales &Credit Memo")
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
            action(ApprovedFundTransfer)
            {
                Caption = 'Fund Transfer Approved';
                RunObject = page "Fund Transfer List-Approved";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewMobileBankingApplication)
            {
                Caption = 'New Mobile Banking Application';
                Image = NewInvoice;
                RunObject = Page "Mobile Banking Appl. Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(NewMobileBankingActivation2)
            {
                Caption = 'New Mobile Banking Activation';
                Image = NewInvoice;
                RunObject = Page "Mobile Banking Activation";
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
        modify(BankAccountReconciliations)
        {
            Visible = false;
        }
        addbefore("Chart of Accounts")
        {
            action(RequestApproval)
            {
                Caption = 'Requests To Approve';
                RunObject = Page "Requests to Approve";
                ApplicationArea = All;
            }
            group(UserManagement)
            {
                Caption = 'User Management';
                action(UserList)
                {
                    Caption = 'User List';
                    RunObject = Page "Users";
                    ApplicationArea = All;
                }
                action(UserSettings)
                {
                    Caption = 'User Role Settings';
                    RunObject = Page 9206;
                    ApplicationArea = All;
                }
                action(UserSetup)
                {
                    Caption = 'User Setup';
                    RunObject = Page "User Setup";
                    ApplicationArea = All;
                }
                action(TellerUserSetup)
                {
                    Caption = 'Teller User Setup';
                    RunObject = Page "Teller User Setup";
                    ApplicationArea = All;
                }
            }
            group(Workflows)
            {
                Caption = 'Workflows';
                action(WorkflowsList)
                {
                    Caption = 'Workflows List';
                    RunObject = Page "Workflows";
                    ApplicationArea = All;
                }
                action(WorkflowUserGroup)
                {
                    Caption = 'Workflow User Group';
                    RunObject = Page "Workflow User Groups";
                    ApplicationArea = All;
                }
            }
            group(Teller)
            {
                Visible = true;
                group("Teller Transaction")
                {
                    action("New Teller Transactions")
                    {
                        RunObject = Page "Teller Transactions List-New";
                        ApplicationArea = All;
                    }
                    action("Posted Teller Transactions")
                    {
                        RunObject = Page "Teller Transactions-Posted";
                        ApplicationArea = All;
                    }
                    action("Cashier Transactions Report")
                    {
                        Caption = 'Cashier Reports';
                        RunObject = report "Cashier Transactions Report";
                        ApplicationArea = All;
                    }
                }
                group("Teller Close Till")
                {
                    Caption = 'Open/Close Till';
                    Visible = true;
                    action("New Teller Close Till")
                    {
                        Caption = 'Teller Open/Close Till List-New';
                        RunObject = Page "Teller Close Till List-New";
                        ApplicationArea = All;
                    }
                    action("Pending Teller Close Till")
                    {
                        Caption = 'Teller Open/Close Till List-Pending';
                        RunObject = Page "Teller Close Till-Pending";
                        ApplicationArea = All;
                    }
                    action("Approved Teller Close Till")
                    {
                        Caption = 'Teller Open/Close Till List-Approved';
                        RunObject = Page "Teller Close Till-Approved";
                        ApplicationArea = All;
                    }
                    action("Rejected Teller Close Till")
                    {
                        Caption = 'Teller Open/Close Till List-Rejected';
                        RunObject = Page "Teller Close Till-Rejected";
                        ApplicationArea = All;
                    }
                }
                group("InterTeller Transfer")
                {
                    action("New InterTeller Transfers")
                    {
                        RunObject = Page "InterTeller Transfers-New";
                        ApplicationArea = All;
                    }
                    action("Pending InterTeller Transfers")
                    {
                        RunObject = Page "InterTeller Transfers-Pending";
                        ApplicationArea = All;
                    }
                    action("Approved InterTeller Transfers")
                    {
                        RunObject = Page "InterTeller Transfers-Approved";
                        ApplicationArea = All;
                    }
                    action("Rejected InterTeller Transfers")
                    {
                        RunObject = Page "InterTeller Transfers-Rejected";
                        ApplicationArea = All;
                    }
                    action("Posted InterTeller Transfers")
                    {
                        RunObject = Page "InterTeller Transfers-Approved";
                        ApplicationArea = All;
                    }
                }
                action(TransactionTypes)
                {
                    Caption = 'Teller Transaction Types';
                    RunObject = Page "Transaction Types List";
                    ApplicationArea = All;
                }
            }

            group(Treasury)
            {
                Visible = true;
                group("Return To Treasury")
                {
                    Caption = 'Teller Receive From/Return To Treasury';
                    action("New Return To Treasury")
                    {
                        Caption = 'New Receive From/Return To Treasury';
                        RunObject = Page "Teller Return Treasury-New";
                        ApplicationArea = All;
                    }
                    action("Pending Return To Treasury")
                    {
                        Caption = 'Pending Receive From/Return To Treasury';
                        RunObject = Page "Teller Return Treasury-Pending";
                        ApplicationArea = All;
                    }
                    action("Approved Return To Treasury")
                    {
                        Caption = 'Approved Receive From/Return To Treasury';
                        RunObject = Page "Teller Ret. Treasury-Approved";
                        ApplicationArea = All;
                    }
                    action("Rejected Return To Treasury")
                    {
                        Caption = 'Rejected Receive From/Return To Treasury';
                        RunObject = Page "Teller Ret. Treasury-Rejected";
                        ApplicationArea = All;
                    }
                    action("Posted Return To Treasury")
                    {
                        Caption = 'Posted Receive From/Return To Treasury';
                        RunObject = Page "Teller Ret. Treasury-Posted";
                        ApplicationArea = All;
                    }
                }

            }
            group(TellerTreasuryACS)
            {
                Caption = 'Cashiers and Treasury Accounts';
                action("Treasury Account List")
                {
                    RunObject = Page "Treasury List";
                    ApplicationArea = All;
                }
                action("Cashier Account List")
                {
                    RunObject = Page "Cashier Account List";
                    ApplicationArea = All;
                }
            }
            group(Members)
            {
                Caption = 'Sacco Members';
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
                action("Loan Classification Setup")
                {
                    ApplicationArea = All;
                    RunObject = page "Classification Setup";
                }
            }
            group(MobileBanking)
            {
                Caption = 'Mobile Banking';
                group(MobileBankingApplication)
                {
                    Caption = 'Mobile Banking Application';
                    action(NewMobileBankingpplication)
                    {
                        Caption = 'New Mobile Banking Applications';
                        RunObject = page "Mobile Banking Appl. List-NEw";
                        ApplicationArea = All;
                    }
                    action(PendingMobileBankingApplication)
                    {
                        Caption = 'Pending Mobile Banking Applications';
                        RunObject = page "Mobile Bk Appl. List-Pending";
                        ApplicationArea = All;
                    }
                    action(ApprovedMobileBankingApplication)
                    {
                        Caption = 'Approved Mobile Banking Applications';
                        RunObject = page "Mobile Bk Appl. List-Approved";
                        ApplicationArea = All;
                    }
                    action(RejectedMobileBankingApplication)
                    {
                        Caption = 'Rejected Mobile Banking Applications';
                        RunObject = page "Mobile Bk Appl. List-Rejected";
                        ApplicationArea = All;
                    }
                }

                action(MobileBankingMember)
                {
                    Caption = 'Mobile Banking Members';
                    RunObject = page "Mobile Banking Members List";
                    ApplicationArea = All;
                }

                action(MobileBankingUnregMember)
                {
                    Caption = 'Unregistered Mobile Banking Members Report';
                    RunObject = report MobileUnregMemberList;
                    ApplicationArea = All;
                }

                group(MobileBankingActivation)
                {
                    Caption = 'Mobile Banking Activation';
                    action(NewMobileBankingActivation)
                    {
                        Caption = 'New Mobile Banking Activations';
                        RunObject = page "Mobile Banking Activ. List-New";
                        ApplicationArea = All;
                    }
                    action(PendingMobileBankingActivation)
                    {
                        Caption = 'Pending Mobile Banking Activations';
                        RunObject = page "Mobile Bk Activ. List-Pending";
                        ApplicationArea = All;
                    }
                    action(ApprovedMobileBankingActivation)
                    {
                        Caption = 'Approved Mobile Banking Activations';
                        RunObject = page "Mobile Bk Activ. List-Approved";
                        ApplicationArea = All;
                    }
                    action(RejectedMobileBankingActivation)
                    {
                        Caption = 'Rejected Mobile Banking Activations';
                        RunObject = page "Mobile Bk Activ. List-Rejected";
                        ApplicationArea = All;
                    }
                }
                action(MobileBankingLedgerEntries)
                {
                    Caption = 'Mobile Banking Ledger Entries';
                    RunObject = page "Mobile Banking Ledger Entries";
                    ApplicationArea = All;
                }
            }
            group(PeriodicActivities)
            {
                Caption = 'Periodic Activities';
                action("CapitalizeInterest2")
                {
                    Caption = 'Run Monthly Interest';
                    ApplicationArea = All;
                    RunObject = report "Run Monthly Interest";
                }
                action(CapitalizeLedgerFee)
                {
                    Caption = 'Capitalize Ledger Fee';
                    ApplicationArea = All;
                    Visible = false;
                    RunObject = report "Capitalize Ledger Fee";
                }
                action(CapitalizePenalty2)
                {
                    Caption = 'Run Monthly Penalty';
                    ApplicationArea = All;
                    RunObject = report "Run Monthly Penalty";
                }
                action(RecoverPenalty)
                {
                    Caption = 'Recover Penalty';
                    ApplicationArea = All;
                    Visible = false;
                    RunObject = report "Recover Penalty Charges.";
                }
                action("Run Standing Order")
                {
                    Visible = false;
                    ApplicationArea = All;
                    RunObject = report "Run Standing Order";
                }
                action("Run Loan Recovery")
                {
                    ApplicationArea = All;
                    RunObject = report "Run Loan Recovery";
                }
                action(OverpaymentTransfer2)
                {
                    Caption = 'Overpayment Transfer';
                    RunObject = report "Overpayment Transfer";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Share Deposits")
                {
                    ApplicationArea = All;
                    RunObject = report "Share Capital End Month";
                }
                action("Benevolent Deposits")
                {
                    ApplicationArea = All;
                    RunObject = report "Benevolent  End Month";
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
                action("Pending Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-Pending";
                }
                action("Approved Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-Approved";
                }
                action("Posted Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-Posted";
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
                Visible = false;
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
                    RunObject = page "MemberSavings WithList-Pending";

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
        }
        addafter("Chart of Accounts")
        {
            group(CBSSetUps)
            {
                Caption = 'Core Banking Setups';
                group(GlobalSetup)
                {
                    Caption = 'Global Setup';
                    action("Global Setup")
                    {
                        ApplicationArea = All;
                        RunObject = page "Global Setup";
                    }
                }
                group(FinanceSetups)
                {
                    Caption = 'Finance Setups';
                    group(DividendsSetup)
                    {
                        Caption = 'Dividends Setup';
                        action("Dividends Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Dividend Setup";
                        }
                        action("Dividend Loan Products")
                        {
                            ApplicationArea = All;
                            RunObject = page "Dividend Loan Products";
                        }
                    }
                    group(FTSetup)
                    {
                        Caption = 'Fund Transfer Setup';
                        action("Fund Transfer Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Fund Transfer Setup";
                        }
                    }
                    group(CashMSetup)
                    {
                        Caption = 'Cash Management Setup';
                        action(CashMgtsetup)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Management Setup';
                            Image = CashFlowSetup;
                            RunObject = Page "Cash Management Setup";
                            ToolTip = 'Set up All Parameters for Cash Management Module';
                        }
                        group("Custom Banks Setup")
                        {
                            action(Banks)
                            {
                                ApplicationArea = Basic, Suite;
                                Image = Bank;
                                RunObject = Page Banks;
                            }
                            action("Bank Branchces")
                            {
                                ApplicationArea = Basic, Suite;
                                Image = Bank;
                                RunObject = Page "Banks Branch";
                            }
                        }
                    }
                }
                group(BosaSetups)
                {
                    Caption = 'BOSA Setups';
                    group(LASetup)
                    {
                        Caption = 'Loan Setup';
                        action("Loan Application Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Loan Application Setup";
                        }
                        action("Loan Charges Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Loan Charge Setup";
                        }
                        action("Loan Securities Register")
                        {
                            ApplicationArea = All;
                            RunObject = page "Securiy Register";
                        }
                        group("Sectoral Setup")
                        {
                            action("Economic Sectors")
                            {
                                ApplicationArea = All;
                                RunObject = page "Economic Sectors";
                            }
                            action("Economic Sector Categories")
                            {
                                ApplicationArea = All;
                                RunObject = page "Economic Sector Categories";
                            }
                            action("Economic Sector Sub-Categories")
                            {
                                ApplicationArea = All;
                                RunObject = page "Economic Sector Sub-Categories";
                            }
                        }
                        group(LSSetup)
                        {
                            Caption = 'Loan Rescheduling Setup';
                            action("Loan Rescheduling Setup")
                            {
                                ApplicationArea = All;
                                RunObject = page "Loan Rescheduling Setup";
                            }
                        }
                        group(LSRSetup)
                        {
                            Caption = 'Loan Restructuring Setup';
                            action("Loan Restructuring Setup")
                            {
                                ApplicationArea = All;
                                RunObject = page "Loan Restructuring Setup";
                            }
                        }
                        group(LNSetup)
                        {
                            Caption = 'Loan Notification Setup';
                            action("Loan Notification Setup")
                            {
                                ApplicationArea = All;
                                RunObject = page "Loan Notification Setup";
                            }
                        }
                        group(GuarantorSubstitutionSetup)
                        {
                            Caption = 'Guarantor Substitution Setup';
                            action("Guarantor Substitution Setup")
                            {
                                ApplicationArea = All;
                                RunObject = page "Guarantor Substitution Setup";
                            }
                        }
                        group(LoanDefaulterSetup)
                        {
                            Caption = 'Loan Defaulter Setup';
                            action("Loan Defaulter Setup")
                            {
                                ApplicationArea = All;
                                RunObject = page "Loan Defaulter Setup";
                            }
                        }
                        group(LoanPTSetup)
                        {
                            Caption = 'Loan Product Types Setup';
                            action("Loan Product Types")
                            {
                                ApplicationArea = All;
                                RunObject = page "Loan Product Type List";
                            }
                        }
                        group(ReportSetup)
                        {
                            Caption = 'Sasra Reports Mapping Setup';
                            action(SasraSetup)
                            {
                                ApplicationArea = All;
                                Caption = 'Setup';
                                Image = Setup;
                                RunObject = page "Sasra Reports Mapping Setup";

                            }
                        }
                        group(LWSetup)
                        {
                            Caption = 'Loan Writeoff Setup';
                            action("Loan Writeoff Setup")
                            {
                                ApplicationArea = All;
                                RunObject = page "Loan Writeoff Setup";
                            }
                        }
                    }
                    group(ExitSetup)
                    {
                        Caption = 'Exit Setup';
                        action("Exit Fees")
                        {
                            ApplicationArea = All;
                            RunObject = page "Exit Fees";
                        }
                        action("Exit Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Exit Setup";
                        }
                    }
                    group(BulkSMSSetup)
                    {
                        Caption = 'Bulk SMS Setup';
                        action("Bulk SMS Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Bulk SMS Setup";
                        }
                    }
                    group(SourceCodesList)
                    {
                        Caption = 'Source Codes List';
                        action("Source Codes")
                        {
                            ApplicationArea = All;
                            RunObject = page "Source Code List";
                        }
                    }
                    group(SourceCodesSetup)
                    {
                        Caption = 'Source Codes Setup';
                        action("Source Code Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Source Code Setup";
                        }
                    }
                }
                group(FosaSetups)
                {
                    Caption = 'FOSA Setups';
                    group(MemberApplicationSetup)
                    {
                        Caption = 'Member Application Setup';
                        action("Member Application Setup")
                        {
                            RunObject = Page "Member Application Setup";
                            ApplicationArea = All;
                        }
                    }

                    group(AccountOpeningSetup)
                    {
                        Caption = 'Account Opening Setup';
                        action("Account Opening Setup")
                        {
                            RunObject = Page "Account Opening Setup";
                            ApplicationArea = All;
                        }
                    }

                    group(MemberActivationSetup)
                    {
                        Caption = 'Member Activation Setup';
                        action("Member Activation Setup")
                        {
                            RunObject = Page "Member Activation Setup";
                            ApplicationArea = All;
                        }
                    }
                    group(TellerSetup)
                    {
                        Caption = 'Teller Setup';
                        action("Teller User Setup")
                        {
                            RunObject = Page "Teller User Setup";
                            ApplicationArea = All;
                        }
                        action("Coinage Setup")
                        {
                            RunObject = Page "Coinage Setup";
                            ApplicationArea = All;
                        }
                        action("Tellering Setup")
                        {
                            RunObject = Page "Tellering Setup";
                            ApplicationArea = All;
                        }
                    }
                    group(TreasurySetup)
                    {
                        Caption = 'Treasury Setup';

                        action("Treasury Setup")
                        {
                            RunObject = Page "Treasury Setup";
                            ApplicationArea = All;
                        }
                    }
                    group(Setup)
                    {
                        action("Account Types")
                        {
                            ApplicationArea = All;
                            RunObject = Page "Account Type List";

                        }
                        action("Transaction Types")
                        {
                            ApplicationArea = All;
                            RunObject = Page "Transaction Types List";

                        }
                        action("Member Categories")
                        {
                            ApplicationArea = All;
                            RunObject = Page "Member Categories";

                        }
                        action(FOSAAgencies)
                        {
                            Caption = 'Agencies';
                            ApplicationArea = All;
                            RunObject = page "Remittance Agent Setup";

                        }
                        action(AuditLogSetup)
                        {
                            Caption = 'Audit Log Setup';
                            ApplicationArea = All;
                            RunObject = Page "Audit Log Table Setup";

                        }

                    }
                }
            }
        }
        addafter(PaymentJournals)
        {

            group("Treasury Return To Bank")
            {
                action("New Treasury Return To Bank")
                {
                    RunObject = Page "Treasury Return Bank List-New";
                    ApplicationArea = All;
                }
                action("Pending Treasury Return To Bank")
                {
                    RunObject = Page "Treasury Return Bank-Pending";
                    ApplicationArea = All;
                }
                action("Approved Treasury Return To Bank")
                {
                    RunObject = Page "Treasury Return Bank-Approved";
                    ApplicationArea = All;
                }
                action("Rejected Treasury Return To Bank")
                {
                    RunObject = Page "Treasury Return Bank-Rejected";
                    ApplicationArea = All;
                }
                action("Posted Treasury Return To Bank")
                {
                    RunObject = Page "Treasury Return Bank-Posted";
                    ApplicationArea = All;
                }
            }
            group(BoardPaymentVouchers)
            {
                Caption = 'Board Members Payment Vouchers';
                Visible = true;
                action(NewBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board Payment Voucher List-New";
                    ToolTip = 'New Board Payment Voucher List stage';
                }
                action(PendingBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board PaymentV List-Pending";
                    ToolTip = 'Pending Board Payment Voucher List stage';
                }
                action(ApprovedBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board PaymentV List-Approved";
                    ToolTip = 'Approved Board Payment Voucher stage';

                }
                action(PostedBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board PaymentV List-Posted";
                    ToolTip = 'Posted Board Payment Voucher stage';
                }
            }

            group(PaymentVouchers)
            {
                Caption = 'Payments Vouchers';

                action(NewPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payment Voucher List-New";
                    ToolTip = 'Reconcile all Payment Voucher List stage';
                }
                action(PendingPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "Payment Voucher List-Pending";
                    ToolTip = 'Reconcile all Payment Voucher List stage';
                }
                action(ApprovedPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "Payment Voucher List-Approved";
                    ToolTip = 'Reconcile all Approved Payment Voucher stage';

                }
                action(PostedPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payment Voucher List-Posted";
                    ToolTip = 'Reconcile all Posted Payment Voucher stage';
                }
            }
            group(Payout)
            {
                Caption = 'Payout Processing';
                action(NewPayoutList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Payout List';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payout List-New";
                    ToolTip = 'New Payout List stage';
                }
                action(PostedPayoutList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Payout List';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payout List-Posted";
                    ToolTip = 'Posted Payout List stage';
                }
            }
            group(PettyCashVouchers)
            {
                Caption = 'PettyCash Vouchers';
                Visible = false;

                action(NewPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash Voucher List-New";
                    ToolTip = 'Reconcile all PettyCash Voucher List stage';
                }
                action(PendingPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash Voucher List-Pending";
                    ToolTip = 'Reconcile all PettyCash Voucher List stage';
                }
                action(ApprovedPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash V. List-Approved";
                    ToolTip = 'Reconcile all Approved PettyCash Voucher stage';

                }
                action(PostedPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash V. List-Posted";
                    ToolTip = 'Reconcile all Posted PettyCash Voucher stage';
                }
            }
            group(ReceiptVouchers)
            {
                Caption = 'Receipt Vouchers';
                //Visible = false;
                action(NewReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Receipt Voucher List-New";
                    ToolTip = 'Reconcile all Receipt Voucher List stage';
                }
                action(PostedReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Receipt Voucher List-Posted";
                    ToolTip = 'Reconcile all Posted Receipt Voucher List stage';
                }
            }
            group(CheckoffReceiptVouchers)
            {
                Caption = 'Checkoff Receipt Vouchers';
                Visible = false;
                action(NewCheckoffReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Checkoff Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff Rct. Voucher List-New";
                    ToolTip = 'Reconcile all Checkoff Receipt Voucher List stage';
                }
                action(PostedCheckoffReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Checkoff Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff Rcpt V. List-Posted";
                    ToolTip = 'Reconcile all Posted Checkoff Receipt Voucher List stage';
                }
            }
            group(Checkoff)
            {
                Caption = 'Checkoff';
                Visible = false;
                action(NewCheckoff)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Checkoffs';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff List-New";
                    ToolTip = 'Reconcile all Checkoffs List stage';

                }
                action(PostedCheckoff)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Checkoffs';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff List-Posted";
                    ToolTip = 'Reconcile all Posted CheckoffsList stage';

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
        }
        addafter(Currencies)
        {

        }
        addbefore(BankAccountReconciliations)
        {
            action(BankReconciliationNew)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Acc. Reconciliations';
                Image = CashFlowSetup;
                RunObject = Page "Bank Acc Reconc. List New";
                ToolTip = 'Bank Account Reconciliations';
            }
        }

        //addbefore(inv)
    }
}
