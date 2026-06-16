page 50354 "FOSA Activities"
{
    PageType = CardPart;
    SourceTable = "FOSA Cue";

    layout
    {
        area(content)
        {

            cuegroup(AccountBalanceCueContainer)
            {
                Caption = 'Account Balances';
                CuegroupLayout = Wide;
                field(TotalOrdinarySavings; ABS(Rec.TotalOrdinarySavings))
                {
                    Caption = 'Total Savings';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        Page.Run(50033);
                    end;
                }
                field(TotalDeposits; ABS(Rec.TotalDeposits))
                {
                    Caption = 'Total Deposits';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        Page.Run(50033);
                    end;
                }
                field(TotalShares; ABS(Rec.TotalShares))
                {
                    Caption = 'Total Shares';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        Page.Run(50033);
                    end;
                }
                field(TotalFixedDeposits; ABS(Rec.TotalFixedDeposits))
                {
                    Caption = 'Total Fixed Deposits';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        Page.Run(50033);
                    end;
                }
                // field(TotalLoans; ABS(TotalLoans))
                // {
                //     Caption = 'Total Loans';
                //     ApplicationArea = All;
                //     trigger OnDrillDown()
                //     var
                //         Vendor: Record Vendor;
                //     begin
                //         Vendor.Reset();
                //         Page.Run(50033);
                //     end;
                // }
            }
            cuegroup(MemberCueContainer)
            {
                Caption = 'Members';
                //CuegroupLayout = Wide;
                field("Member-Active"; Rec."Member-Active")
                {
                    Caption = 'Active';
                    DrillDownPageId = "Member List";
                    ApplicationArea = All;
                }
                field("Member-Dormant"; Rec."Member-Dormant")
                {
                    Caption = 'Dormant';
                    DrillDownPageId = "Member List";
                    ApplicationArea = All;
                }
                field("Member-Withdrawn"; Rec."Member-Withdrawn")
                {
                    Caption = 'Withdrawn';
                    DrillDownPageId = "Member List";
                    ApplicationArea = All;
                }
                field("Member-Suspended"; Rec."Member-Suspended")
                {
                    Caption = 'Suspended';
                    DrillDownPageId = "Member List";
                    ApplicationArea = All;
                }


            }
            cuegroup(MobileBankingMemberCueContainer)
            {
                Caption = 'Mobile Banking Members';
                //CuegroupLayout = Wide;
                field("MobileBankingMember-Active"; Rec."MobileBankingMember-Active")
                {
                    Caption = 'Active';
                    DrillDownPageId = "Mobile Banking Members List";
                    ApplicationArea = All;
                }
                field("MobileBankingMember-Inactive"; Rec."MobileBankingMember-Inactive")
                {
                    Caption = 'Inactive';
                    DrillDownPageId = "Mobile Banking Members List";
                    ApplicationArea = All;
                }


            }
            cuegroup(ChequeBookCueContainer)
            {
                Caption = 'Cheque Books';
                //CuegroupLayout = Wide;
                field("ChequeBook-New"; Rec."ChequeBook-New")
                {
                    Caption = 'New';
                    DrillDownPageId = "Cheque Book List-New";
                    ApplicationArea = All;
                }
                field("ChequeBook-Issued"; Rec."ChequeBook-Issued")
                {
                    Caption = 'Issued';
                    DrillDownPageId = "Cheque Book List-Issued";
                    ApplicationArea = All;
                }


            }





            cuegroup(MemberApplicationActionContainer)
            {
                Caption = 'Member Application';

                actions
                {

                    action("New Member Application")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Member Application Card";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(AccountOpeningActionContainer)
            {
                Caption = 'Account Opening';

                actions
                {

                    action("New Account Opening")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Account Opening Card";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(MobileBankingApplicationActionContainer)
            {
                Caption = 'Mobile Banking Application';

                actions
                {

                    action("New Mobile Banking Application")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Mobile Banking Appl. Card";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }

            cuegroup(ATMApplicationActionContainer)
            {
                Caption = 'ATM Application';

                actions
                {

                    action("New ATM Application")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "ATM Application Card";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(AgentApplicationActionContainer)
            {
                Caption = 'Agent Application';

                actions
                {

                    action("New Agent Application")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Agent Application";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET;
        if not Rec.FindSet() then begin
            Rec.INIT();
            Rec.INSERT();
        end;

    end;

    local procedure CalculateAccountBalance()
    var
        Vendor: Record Vendor;
        AccountType: Record "Account Type";
    begin
        AccountType.Reset();
        if AccountType.FindSet() then begin
            repeat
                Vendor.Reset();
                Vendor.SetRange("Account Type", AccountType.Code);
                if Vendor.FindSet() then begin
                    repeat
                        Vendor.CalcFields("Balance (LCY)");
                        if AccountType.Type = AccountType.Type::Savings then
                            Rec.TotalOrdinarySavings += Vendor."Balance (LCY)";
                        if AccountType.Type = AccountType.Type::"Member Deposit" then
                            Rec.TotalDeposits += Vendor."Balance (LCY)";
                        if AccountType.Type = AccountType.Type::"Share Capital" then
                            Rec.TotalShares += Vendor."Balance (LCY)";
                        if AccountType.Type = AccountType.Type::"Fixed Deposit" then
                            Rec.TotalFixedDeposits += Vendor."Balance (LCY)";

                    until Vendor.Next() = 0
                end;
            until AccountType.Next() = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    var
    begin
        CalculateAccountBalance();
    end;

}