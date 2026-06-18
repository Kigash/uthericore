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
            group(Reports)
            {
                action(DailyCashAnalysis2)
                {
                    Caption = 'Daily Cash Analysis';
                    Image = "Report";
                    RunObject = Report "Daily Cash Analysis";
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        area(Creation)
        {
            action(NewTellerTransaction)
            {
                Caption = 'New Teller Transaction';
                Image = NewInvoice;
                RunObject = Page "Teller Transaction Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
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

