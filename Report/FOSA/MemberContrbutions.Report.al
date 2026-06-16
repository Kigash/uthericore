report 50007 "Member Contributions"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report/FOSA/MemberContribution.rdl';

    dataset
    {
        dataitem(Member; Member)
        {
            // DataItemTableView = where(Category = filter('Individual'));
            RequestFilterFields = "No.", "Global Dimension 1 Code", Status, Gender;

            column(No_; "No.")
            {
            }
            column(Full_Name; "Full Name")
            {
            }
            column(Phone_No_; "Phone No.")
            {
            }
            column(Shares; SharesAmount)
            {
            }
            column(Deposits; DepositAmount)
            {
            }
            column(Ordinary; SavingsAmount)
            {
            }
            column(EndDate; EndDate)
            {

            }
            column(Picture; CompInfo.Picture)
            {

            }
            column(CompName; CompInfo.Name)
            {

            }


            trigger OnAfterGetRecord()
            begin
                GetMemberBalances("No.", SharesAmount, DepositAmount, SavingsAmount);
            end;


            trigger OnPreDataItem()

            begin
                CompInfo.Get();
                CompInfo.CalcFields(Picture);
                if AsAtDate = 0D then
                    AsAtDate := Today;

                EndDate := AsAtDate;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsAtDate; AsAtDate)
                {
                    Caption = 'As At Date';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        AccountBal: array[3] of Decimal; // 1: Shares, 2: Deposits, 3: Ordinary Savings
        AccountType: Record "Account Type";
        Vendor: Record Vendor;
        CompanyInformation: Record "Company Information";
        AsAtDate: Date;
        SharesAmount, DepositAmount, SavingsAmount : Decimal;
        EndDate: Date;

        CompInfo: Record "Company Information";

    local procedure GetMemberBalances(MemberNo: Code[20]; var SharesAmount: Decimal; var DepositAmount: Decimal; var SavingsAmount: Decimal)
    var
        DetVend: Record "Detailed Vendor Ledg. Entry";
        Vendor: Record Vendor;
        AccountType: Record "Account Type";
    begin
        SharesAmount := 0;
        DepositAmount := 0;
        SavingsAmount := 0;

        AccountType.Reset();
        AccountType.SetFilter(Type, '%1|%2|%3', AccountType.Type::"Member Deposit", AccountType.Type::Savings, AccountType.Type::"Share Capital");
        if AccountType.FindSet() then begin
            repeat
                Vendor.Reset();
                Vendor.SetRange("Member No.", MemberNo);
                Vendor.SetRange("Account Type", AccountType.Code);
                if Vendor.FindFirst() then begin
                    DetVend.Reset();
                    DetVend.SetRange("Vendor No.", Vendor."No.");
                    DetVend.SetFilter("Posting Date", '<=%1', AsAtDate);
                    if DetVend.FindSet then begin
                        DetVend.CalcSums(Amount);
                        case AccountType.Type of
                            AccountType.Type::"Share Capital":
                                SharesAmount := Abs(DetVend.Amount);
                            AccountType.Type::"Member Deposit":
                                DepositAmount := Abs(DetVend.Amount);
                            AccountType.Type::Savings:
                                if AccountType."Sub Type" = AccountType."Sub Type"::Ordinary then
                                    SavingsAmount := Abs(DetVend.Amount);
                        end;
                    end;
                end;
            until AccountType.Next() = 0;
        end;
    end;

}



/* 
report 50007 "Member Contributions"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report/FOSA/MemberContribution.rdl';
    dataset
    {

        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1));
            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            column(Picture; CompInfo.Picture)
            {

            }
            column(CompName; CompInfo.Name)
            {

            }
            dataitem(Member; Member)
            {
                column(No_; "No.")
                {

                }
                column(Full_Name; "Full Name")
                {

                }
                column(Phone_No_; "Phone No.")
                {

                }

                column(ContributionAmount_1; ContributionAmount[1])
                {

                }

                column(ContributionAmount_2; ContributionAmount[2])
                {

                }
                column(ContributionAmount_3; ContributionAmount[3])
                {

                }
                column(ContributionAmount_4; ContributionAmount[4])
                {

                }

                trigger OnAfterGetRecord()
                var

                begin
                    CalculateMemberContribution("No.", ContributionAmount[1], ContributionAmount[2], ContributionAmount[3], ContributionAmount[4]);
                end; 



            }

        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;

                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;

                    }



                }

            }

        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture)
    end;

    local procedure CalculateMemberContribution(MemberNo: Code[20]; var SavingsAmount: Decimal; var DepositAmount: Decimal; var SharesAmount: Decimal; var ServiceChargeAmount: Decimal)
    var
        myInt: Integer;
    begin
        SavingsAmount := 0;
        DepositAmount := 0;
        SharesAmount := 0;

        Vendor.Reset();
        Vendor.SetRange("Member No.", MemberNo);
        if Vendor.FindSet() then begin
            repeat
                AccountType.Get(Vendor."Account Type");
                if AccountType.Type = AccountType.Type::Savings then begin
                    if AccountType."Sub Type" = AccountType."Sub Type"::Ordinary then
                        SavingsAmount += CalculateVLE(Vendor."No.");
                end;
                if AccountType.Type = AccountType.Type::"Member Deposit" then begin
                    DepositAmount += CalculateVLE(Vendor."No.");
                end;
                if AccountType.Type = AccountType.Type::"Share Capital" then begin
                    SharesAmount += CalculateVLE(Vendor."No.");
                end;

            until Vendor.Next() = 0;
        end;

        ServiceChargeAmount := CalculateTellerTrx(MemberNo);

    end;

    local procedure CalculateVLE(AccountNo: Code[20]): Decimal
    var
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
        VendorLedgerEntry.SetRange("Vendor No.", AccountNo);
        VendorLedgerEntry.SetFilter("Source Code", '<>%1', 'OPENBAL');
        if VendorLedgerEntry.FindSet() then begin
            repeat
                VendorLedgerEntry.CalcFields(Amount);
                TotalAmount += VendorLedgerEntry.Amount;
            until ((VendorLedgerEntry.Next() = 0))
        end;
        exit(Abs(TotalAmount))
    end;

    local procedure CalculateTellerTrx(MemberNo: Code[20]): Decimal
    var
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        TellerTransactionHeader.Reset();
        TellerTransactionHeader.SetRange(Posted, true);
        TellerTransactionHeader.SetRange("Transaction Date", StartDate, EndDate);
        if TellerTransactionHeader.FindSet() then begin
            repeat
                TellerTransactionLine.Reset();
                TellerTransactionLine.SetRange("Transaction No.", TellerTransactionHeader."No.");
                TellerTransactionLine.SetRange("Member No.", MemberNo);
                TellerTransactionLine.SetFilter("Account No.", '003');
                if TellerTransactionLine.FindSet() then begin
                    repeat
                        TotalAmount += TellerTransactionLine."Line Amount"
                    until ((TellerTransactionLine.Next() = 0))
                end;

            until TellerTransactionHeader.Next() = 0;
        end;
        exit(Abs(TotalAmount))
    end;

    var
        StartDate: Date;
        EndDate: Date;


        MemberContribution: Record "Member Contribution";
        TempContribution: Record "Member Contribution" temporary;
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";

        ContributionAmount: array[4] of Decimal;
        CompInfo: Record "Company Information";
        AccountType: Record "Account Type";

        TellerTransactionLine: Record "Teller Transaction Line";
        TellerTransactionHeader: Record "Teller Transaction Header";

}
 */
