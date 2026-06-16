page 57351 "Feild Coll RoleCenter"
{
    PageType = RoleCenter;
    Caption = 'Feild Collection Role Center';
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
            group("Return To Cashier")
            {
                Caption = 'Return To Cashier';
                action("New Return To Cashier")
                {
                    RunObject = Page "FieldColl RetuCashier-New";
                    ApplicationArea = All;
                }
                action("Pending Return To Cashier")
                {
                    Visible = false;
                    RunObject = Page "FieldColl RetuCashier-Pending";
                    ApplicationArea = All;
                }
                action("Approved Return To Cashier")
                {
                    Visible = false;
                    RunObject = Page "FieldColl RetuCashier-Approved";
                    ApplicationArea = All;
                }
                action("Rejected Return To Cashier")
                {
                    Visible = false;
                    RunObject = Page "FieldColl RetuCashier-Rejected";
                    ApplicationArea = All;
                }
                action("Posted Return To Cashier")
                {
                    RunObject = Page "FieldColl RetuCashier-Posted";
                    ApplicationArea = All;
                }
            }
            group(Report)
            {
                action("Field Collection Report")
                {
                    Caption = 'Field Collection Report';
                    RunObject = report "Cashier Transactions Report";
                    ApplicationArea = All;
                }
                action("Update Member Accounts")
                {
                    Caption = 'Update Member Accounts';
                    RunObject = codeunit "Audit Management";
                    ApplicationArea = All;
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
            group(FOSAReports2)
            {
                Caption = 'FOSA Reports';
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
profile FieldCollProfile
{
    ProfileDescription = 'Field Collection Profile';
    RoleCenter = "Feild Coll RoleCenter";
    Caption = 'Field Cllection';
}

