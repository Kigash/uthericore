page 56351 "Teller RoleCenter"
{
    PageType = RoleCenter;
    Caption = 'Teller Role Center';
    layout
    {
        area(RoleCenter)
        {
            part(Part1; "Teller RoleCenter Headline")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
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
                group(PaymentVouchers)
                {
                    Caption = 'Payments Vouchers';

                    action(NewPaymentVoucherlist)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Payment Vouchers';
                        Image = CashFlow;
                        RunObject = Page "Payment Voucher List-New";
                        ToolTip = 'Reconcile all Payment Voucher List stage';
                    }
                    action(PostedPaymentVoucherlist)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Payment Vouchers';
                        Image = CashFlow;
                        RunObject = Page "Payment Voucher List-Posted";
                        ToolTip = 'Reconcile all Posted Payment Voucher stage';
                    }
                }
                group("InterTeller Transfer")
                {
                    Visible = false;
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
                group(CashierReports)
                {
                    Caption = 'Cashier Reports';
                    action("Cashier Transactions Report")
                    {
                        RunObject = report "Cashier Transactions Report";
                        ApplicationArea = All;
                    }
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
            }


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
                action("Rejected Member Applications")
                {
                    //  RunObject = Page
                    ApplicationArea = All;
                }
            }
            group(MembersAndAccounts)
            {
                Caption = 'Members & Member Accounts';
                action(FOSAMembers)
                {
                    Caption = 'Members';
                    RunObject = Page "Member List";
                    ApplicationArea = All;
                }
                action(SDAccounts)
                {
                    Caption = 'Savings Accounts';
                    RunObject = Page "Member S/Dep. Account List";
                    ApplicationArea = All;
                }
                action(LoanAccounts)
                {
                    Caption = 'Loan Accounts';
                    RunObject = Page "Member Loan Account List";
                    ApplicationArea = All;
                }
                action("Requests To Approve")
                {
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = All;
                }
                group(FOSAReports)
                {
                    Caption = 'Reports';
                    action("Member Statement")
                    {
                        RunObject = report "Member Statement";
                        ApplicationArea = All;
                    }
                    action("Loan Statement")
                    {
                        RunObject = report "Member Loan Statement";
                        ApplicationArea = All;
                    }
                    action("Fixed/Call Deposit Summary")
                    {
                        RunObject = report "Fixed/Call Deposit Summary";
                        ApplicationArea = All;
                    }
                }
            }
            group("Group")
            {
                Caption = 'General Ledger';
                action("Chart of Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    RunObject = page "Chart of Accounts";
                }
                action("General Journals1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    RunObject = page "General Journal";
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


            group(FOSAPeriodicActivities)
            {
                Caption = 'Periodic Activities';

                action("Mature Fixed/Call Deposit")
                {
                    ApplicationArea = All;
                    RunObject = report "Mature Fixed/Call Deposit";

                }
            }
            group(FOSAReports2)
            {
                Caption = 'Reports';
                action(MemberStatement)
                {
                    Caption = 'Members Statement';
                    ApplicationArea = All;
                    RunObject = report "Member Statement";
                }
                action(LoanStatement)
                {
                    Caption = 'Loan Statement';
                    ApplicationArea = All;
                    RunObject = report "Member Loan Statement";
                }
                action(MemberStatementCombined)
                {
                    Caption = 'Member Statement-Combined';
                    ApplicationArea = All;
                    RunObject = report "Member Statement-Combined";
                }
                action(MemberListingReport)
                {
                    Caption = 'Member Listing Report';
                    ApplicationArea = All;
                    RunObject = report "Member Listing Report";
                }
                action(MemberAccountsSummary)
                {
                    Caption = 'Members & Accounts Summary';
                    ApplicationArea = All;
                    RunObject = report "Members & Accounts Summary";
                }
                action(MobileBankingReport)
                {
                    Caption = 'Mobile Banking Transactions';
                    ApplicationArea = All;
                    RunObject = report "Mobile Banking Transactions";
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
            action(MembersJoint)
            {
                Caption = 'Joint Members';
                RunObject = Page "Member List Joint";
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
            action(RequestApproval)
            {
                Caption = 'Requests To Approve';
                RunObject = Page "Requests to Approve";
                ApplicationArea = All;

            }

            action("SMSEntries")
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

                action(MatureFixedCallDeposit)
                {
                    Caption = 'Mature Fixed/Call Deposit';
                    RunObject = report "Mature Fixed/Call Deposit";
                    ApplicationArea = All;
                }

            }
            group(Reports)
            {
                action(DailyCashAnalysis2)
                {
                    Caption = 'Daily Cash Analysis';
                    Image = "Report";
                    RunObject = Report "Daily Cash Analysis";
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
            action(NewAccountOpening)
            {
                Caption = 'New Account Opening';
                Image = NewInvoice;
                RunObject = Page "Account Opening Card";
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

        }
    }
}
// Creates a profile that uses the Role Center
profile TellerProfile
{
    ProfileDescription = 'Teller Profile';
    RoleCenter = "Teller RoleCenter";
    Caption = 'Teller';
}

