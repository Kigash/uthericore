pageextension 50013 ITManagerRoleCenterExt extends "Administrator Main Role Center"
{
    layout
    {
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
        }

    }
    actions
    {
        addfirst(Creation)
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
        addbefore(Group)
        {
            group(RequestApproval)
            {
                Caption = 'Requests To Approve';
                action("Requests to Approve")
                {
                    RunObject = Page "Requests to Approve";
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

                group(MobileBankingSetup)
                {
                    Caption = 'Setup';
                    action(MobileBankingSetup2)
                    {
                        Caption = 'Mobile Banking Setup';
                        RunObject = page "Mobile Banking Setup";
                        ApplicationArea = All;
                    }
                }
            }
            group("Agency Banking")
            {
                Caption = 'Agency Banking';
                Visible = true;
                Enabled = false;
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
                        RunObject = page "Agent List";
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
        }
        addafter(Group19)
        {
            group(Audit)
            {
                action(AuditLogEntries)
                {
                    Caption = 'Audit Log Entries';
                    ApplicationArea = All;
                    RunObject = Page "Audit Log Entries";

                }
            }
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
                    group(CashSetup)
                    {
                        Caption = 'Cash Management Setup';
                        action(Cashmngetsetup)
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
                        group(LoanClassification)
                        {
                            Caption = 'Loan Classification Setup';
                            action("Loan Classification Setup")
                            {
                                ApplicationArea = All;
                                RunObject = page "Classification Setup";
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
        modify("Table Information")
        {
            Visible = false;
        }
        modify("System Information")
        {
            Visible = false;
        }
        modify("Devices")
        {
            Visible = false;
        }
        modify("Control Add-ins")
        {
            Visible = false;
        }
        modify("Printer Management")
        {
            Visible = false;
        }
        modify("Post Codes")
        {
            Visible = false;
        }
        modify("Group2")
        {
            Visible = false;
        }
        modify("Group6")
        {
            Visible = false;
        }
        modify("Group7")
        {
            Visible = false;
        }
        modify("Feature Management")
        {
            Visible = false;
        }
        modify("Territories")
        {
            Visible = false;
        }
        modify("Languages")
        {
            Visible = false;
        }
        modify("Countries/Regions")
        {
            Visible = false;
        }
        modify("Base Calendar Entries Subform")
        {
            Visible = false;
        }
        modify("Responsibility Centers")
        {
            Visible = false;
        }
        modify("Group10")
        {
            Visible = false;
        }
        modify("Group11")
        {
            Visible = false;
        }
        modify("Group12")
        {
            Visible = false;
        }
        modify("Group13")
        {
            Visible = false;
        }
        modify("Group15")
        {
            Visible = false;
        }
        modify("Group23")
        {
            Visible = false;
        }
        modify("Group26")
        {
            Visible = false;
        }
        modify("Group27")
        {
            Visible = false;
        }
        modify("Group28")
        {
            Visible = false;
        }
    }
}
