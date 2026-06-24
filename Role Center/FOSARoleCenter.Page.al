page 50351 "FOSA RoleCenter"
{
    PageType = RoleCenter;
    Caption = 'FOSA Role Center';
    layout
    {
        /*        area(RoleCenter)
                {

                    part(Part1; "FOSA RoleCenter Headline")
                    {
                        ApplicationArea = All;
                    }

                    part(Part2; "FOSA Activities")
                    {
                        Caption = 'FOSA';
                        ApplicationArea = All;
                    }
                    part(Control1; "Membership Analysis Chart")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                    }
                    part(Control2; "Branch Analysis-Acc Type Chart")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                    }
                }*/
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
                }
            }
            group(AccountOpening)
            {
                Caption = 'Account Opening';
                action("New Account Opening")
                {
                    RunObject = Page "Account Opening List-New";
                    ApplicationArea = All;
                }
                action("Pending Account Opening")
                {
                    RunObject = Page "Account Opening List-Pending";
                    ApplicationArea = All;
                }
                action("Approved Account Opening")
                {
                    RunObject = Page "Account Opening List-Approved";
                    ApplicationArea = All;
                }
                action("Rejected Account Opening")
                {
                    RunObject = Page "Account Opening List-Rejected";
                    ApplicationArea = All;
                }
            }
            group(MemberActivation)
            {
                Caption = 'Member Activation';
                action("New Member Activations")
                {
                    RunObject = Page "Member Activation List";
                    ApplicationArea = All;
                }
                action("Pending Member Activations")
                {
                    RunObject = Page "Member Activation List-Pending";
                    ApplicationArea = All;
                }
                action("Approved Member Activations")
                {
                    RunObject = Page "Member Activ. List-Approved";
                    ApplicationArea = All;
                }
                action("Rejected Member Activations")
                {
                    RunObject = Page "Member Activ. List-Rejected";
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
            group(Tellering)
            {
                Visible = false;
                group("Teller Transaction")
                {
                    action("New Teller Transactions")
                    {
                        RunObject = Page "Teller Transactions List-New";
                        ApplicationArea = All;
                    }
                    action("Pending Teller Transactions")
                    {
                        RunObject = Page "Teller Transactions-Pending";
                        ApplicationArea = All;
                    }
                    action("Approved Teller Transactions")
                    {
                        RunObject = Page "Teller Transactions-Approved";
                        ApplicationArea = All;
                    }
                    action("Rejected Teller Transactions")
                    {
                        RunObject = Page "Teller Transactions-Rejected";
                        ApplicationArea = All;
                    }
                    action("Posted Teller Transactions")
                    {
                        RunObject = Page "Teller Transactions-Posted";
                        ApplicationArea = All;
                    }
                }
                group("Return To Treasury")
                {
                    action("New Return To Treasury")
                    {
                        RunObject = Page "Teller Return Treasury-New";
                        ApplicationArea = All;
                    }
                    action("Pending Return To Treasury")
                    {
                        RunObject = Page "Teller Return Treasury-Pending";
                        ApplicationArea = All;
                    }
                    action("Approved Return To Treasury")
                    {
                        RunObject = Page "Teller Ret. Treasury-Approved";
                        ApplicationArea = All;
                    }
                    action("Rejected Return To Treasury")
                    {
                        RunObject = Page "Teller Ret. Treasury-Rejected";
                        ApplicationArea = All;
                    }
                    action("Posted Return To Treasury")
                    {
                        RunObject = Page "Teller Ret. Treasury-Posted";
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
                group("Teller Close Till")
                {
                    action("New Teller Close Till")
                    {
                        RunObject = Page "Teller Close Till List-New";
                        ApplicationArea = All;
                    }
                    action("Pending Teller Close Till")
                    {
                        RunObject = Page "Teller Close Till-Pending";
                        ApplicationArea = All;
                    }
                    action("Approved Teller Close Till")
                    {
                        RunObject = Page "Teller Close Till-Approved";
                        ApplicationArea = All;
                    }
                    action("Rejected Teller Close Till")
                    {
                        RunObject = Page "Teller Close Till-Rejected";
                        ApplicationArea = All;
                    }
                    action("Posted Teller Close Till")
                    {
                        RunObject = Page "Teller Close Till-Approved";
                        ApplicationArea = All;
                    }


                }

            }
            group(Treasury)
            {
                Visible = false;
                group("Treasury Transaction")
                {
                    action("New Treasury Transactions")
                    {
                        RunObject = Page "Treasury Transactions List-New";
                        ApplicationArea = All;
                    }
                    action("Pending Treasury Transactions")
                    {
                        RunObject = Page "Treasury Transactions-Pending";
                        ApplicationArea = All;
                    }
                    action("Approved Treasury Transactions")
                    {
                        RunObject = Page "Treasury Transactions-Approved";
                        ApplicationArea = All;
                    }
                    action("Rejected Treasury Transactions")
                    {
                        RunObject = Page "Treasury Transactions-Rejected";
                        ApplicationArea = All;
                    }
                    action("Posted Treasury Transactions")
                    {
                        RunObject = Page "Treasury Transactions-Posted";
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
                action(MobileChargeGLSetup)
                {
                    Caption = 'Mobile Charge GL Setup';
                    RunObject = page "Mobile Charge GL Setup List";
                    ApplicationArea = All;
                }
            }
            group("Agency Banking")
            {
                Caption = 'Agency Banking';
                Visible = true;
                Enabled = true;
                group(AgentApplication)
                {
                    Caption = 'Agent Application';
                    action(NewAgentApplication)
                    {
                        Caption = 'New Agent Applications';
                        RunObject = page "Agent Application List-New";
                        ApplicationArea = All;
                    }
                    action(PendingAgentApplication)
                    {
                        Caption = 'Pending Agent Applications';
                        RunObject = page "Agent Applications-Pending";
                        ApplicationArea = All;
                    }
                    action(ApprovedAgentApplication)
                    {
                        Caption = 'Approved Agent Applications';
                        RunObject = page "Agent Applications-Approved";
                        ApplicationArea = All;
                    }
                    action(RejectedAgentApplication)
                    {
                        Caption = 'Rejected Agent Applications';
                        RunObject = page "Agent Applications-Rejected";
                        ApplicationArea = All;
                    }
                }
                group(Agents)
                {
                    action(ActiveAgents)
                    {
                        Caption = 'Agents';
                        RunObject = page "Agency Agent List";
                        ApplicationArea = All;
                    }
                }
                group(AgencyLedgerEntries)
                {
                    Caption = 'Ledger Entries';
                    action(LedgerEntries)
                    {
                        Caption = 'Ledger Entries';
                        RunObject = page "Agency Ledger Entries";
                        ApplicationArea = All;
                    }
                }
                group(AgencyBankingSetup)
                {
                    Caption = 'Agency Setup';
                    action(AgencyBankingSetupAction)
                    {
                        Caption = 'Agency Setup';
                        RunObject = page "Agency Banking Setup";
                        ApplicationArea = All;
                    }
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
            group(Members)
            {
                Caption = 'Members';
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
            group(BulkSMS)
            {
                Caption = 'Bulk SMS';
                action("BulkSMSNew")
                {
                    Caption = 'New Bulk SMS';
                    RunObject = Page "Bulk SMS To Members List";
                    ApplicationArea = All;
                }
                action("SentBulkSMS")
                {
                    Caption = 'Sent Bulk SMS';
                    RunObject = Page "Bulk SMS To Members Sent List";
                    ApplicationArea = All;
                }
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
                action(CheckDormancy)
                {
                    Caption = 'Check Dormancy';
                    RunObject = report "Check Dormancy";
                    ApplicationArea = All;
                }
                action(MatureFixedCallDeposit)
                {
                    Caption = 'Mature Fixed/Call Deposit';
                    RunObject = report "Mature Fixed/Call Deposit";
                    ApplicationArea = All;
                }
            }
            group(Reports)
            {
                action(MemberStatement3)
                {
                    Caption = 'Members Statement';
                    ApplicationArea = All;
                    RunObject = report "Member Statement";
                }
                action(LoanStatement3)
                {
                    Caption = 'Loan Statement';
                    ApplicationArea = All;
                    RunObject = report "Member Loan Statement";
                }
                action(MemberStatementCombined3)
                {
                    Caption = 'Member Statement-Combined';
                    ApplicationArea = All;
                    RunObject = report "Member Statement-Combined";
                }
                action(MemberListingReport3)
                {
                    Caption = 'Member Listing Report';
                    ApplicationArea = All;
                    RunObject = report "Member Listing Report";
                }
                action(MemberContribution2)
                {
                    Caption = 'Member Contributions';
                    Image = "Report";
                    RunObject = Report "Member Contributions";
                    ApplicationArea = All;
                }
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
profile FOSAProfile
{
    ProfileDescription = 'FOSA Profile';
    RoleCenter = "FOSA RoleCenter";
    Caption = 'FOSA';
}

