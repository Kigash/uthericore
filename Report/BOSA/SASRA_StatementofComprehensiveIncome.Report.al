
report 50122 "Statement of Compre. Income"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report\BOSA\StatementofComprehensiveIncome.rdl';
    Caption = 'Statement of Comprehensive Income';

    dataset
    {
        dataitem(Integer; Integer)
        {
            // DataItemTableView=sorting()
            column(Number; Number)
            {
            }
            column(IntLoanPort; Amount[1])
            {

            }
            column(FeeCommLoanP; Amount[2])
            {

            }
            column(GovSecurities; Amount[3])
            {

            }
            column(Placements; Amount[4])
            {

            }
            column(CommPapers; Amount[5])
            {

            }
            column(CollInv; Amount[6])
            {

            }
            column(Derivatives; Amount[7])
            {

            }
            column(EqInv; Amount[8])
            {

            }
            column(InvCompany; Amount[9])
            {

            }
            column(IntExpDep; Amount[10])
            {

            }
            column(CostEBorr; Amount[11])
            {

            }
            column(DivExpe; Amount[12])
            {

            }
            column(OthrFinExpe; Amount[13])
            {

            }
            column(FeeCommExpe; Amount[14])
            {

            }
            column(OtherExpe; Amount[15])
            {

            }
            column(ProvLoanLoss; Amount[16])
            {

            }
            column(VLoansRec; Amount[17])
            {

            }
            column(PersExpe; Amount[18])
            {

            }
            column(GovExpe; Amount[19])
            {

            }
            column(MarkExpe; Amount[20])
            {

            }
            column(DepAmmExpe; Amount[21])
            {

            }
            column(AdminExpe; Amount[22])
            {

            }
            column(NonOpInc; Amount[23])
            {

            }
            column(NonOpExpe; Amount[24])
            {

            }
            column(Taxes; Amount[25])
            {

            }
            column(Donations; Amount[26])
            {

            }
            trigger OnPreDataItem()
            var

            begin
                Setrange(Number, 1, 1)
            end;

            trigger OnAfterGetRecord()
            begin
                SasraSetup.Get();
                Dfilter := '..' + Format(AsAt);

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Interest on Portfolio");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[1] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                //5279|5411
                GLAccount.SetFilter("No.", '%1|%2', '5279', '5411');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[2] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', '5302');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[3] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1|%2|%3', SasraSetup."Sacco Balances", SasraSetup."Other Balances", SasraSetup."Bal Commercial Banks");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[4] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Commercial Papers");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[5] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1|%2|%3|%4', '5301', '5303', '5304', '5300');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[6] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup.Derivatives);
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[7] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Equity Investments");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[8] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', '5469');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[9] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Interest Expense on Deposits");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[10] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Cost of External Borrowings");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[11] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Dividend Expenses");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[12] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Other Financial Expense");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[13] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Fees & Comm Expense");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[14] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Other Expense");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[15] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Provision for loan Losses");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[16] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Value of Loans Recovered");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[17] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Personnel Expense");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[18] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                //GLAccount.SetFilter("No.", '%1', SasraSetup."Governance Expense");
                GLAccount.SetFilter("No.", '%1|%2|%3|%4|%5|%6|%7|%8', '6200', '6201', '6202', '6203', '6208', '6209', '6212', '6213');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        // Message('Account No %1', GLAccount."No.");
                        GLAccount.CalcFields(Balance);
                        Amount[19] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Marketing Expense");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[20] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup."Depreciation & Amortization");
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[21] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', SasraSetup."Administrative Expense", '6204', '6205', '6206', '6207', '6209', '6211', '6617', '7606', '7607', '7608');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[22] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11|%12|%13', '5412', '5413', '5414', '5415', '5416', '5417', '5418', '5419', '5420', '5489', '5509', '5529', '5599');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[23] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                //GLAccount.SetFilter("No.", '%1', SasraSetup."Non-Operating Expense");
                GLAccount.SetFilter("No.", '%1|%2|%3|%4|%5', '7116', '7118', '7122', '7603', '7609');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[24] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', '7607');
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[25] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;
                GLAccount.Reset();
                GLAccount.SetFilter("No.", '%1', SasraSetup.Donations);
                GLAccount.SetFilter("Date Filter", Dfilter);
                if GLAccount.FindSet() then begin
                    repeat
                        GLAccount.CalcFields(Balance);
                        Amount[26] += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;
                        Caption = 'As At Date';

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

    var
        myInt: Integer;
        AsAt: Date;
        Dfilter: Text;
        SasraSetup: Record SasraReportsMappingSetup;
        Amount: array[150] of Decimal;
        GLAccount: Record "G/L Account";
}