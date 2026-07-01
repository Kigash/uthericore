report 50292 "Trial Balance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Finance\Trial Balance Report.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            column(No_; "G/L Account"."No.")
            {
            }
            column(Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
            {
            }
            column(Net_Change; "G/L Account"."Net Change")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Bold_control; BoldControl)
            {
            }
            column(Debit; Debit)
            {
            }
            column(Credit; Credit)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(TotalDebits; TotalDebits)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }

            trigger OnAfterGetRecord();
            begin
                "G/L Account".CALCFIELDS("Net Change");
                BoldControl := false;
                Debit := 0;
                Credit := 0;

                if ("G/L Account"."Net Change" = 0) and ("G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting) then
                    CurrReport.SKIP();
                if ("G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting) then
                    BoldControl := true;

                if ("G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting) then begin
                    if "G/L Account"."Net Change" > 0 then
                        Debit := "G/L Account"."Net Change"
                    else
                        Credit := "G/L Account"."Net Change" * -1;
                end;

                if Debit > 0 then
                    TotalDebits := TotalDebits + Debit;

                if Credit > 0 then
                    TotalCredits := TotalCredits + Credit;

                //MESSAGE('%1 %2 %3 %4',Debit,Credit,TotalDebits,TotalCredits);
            end;

            trigger OnPreDataItem();
            begin
                if EndDate = 0D then
                    EndDate := TODAY;

                Dfilter := FORMAT(StartDate) + '..' + FORMAT(EndDate);
                SETFILTER("Date Filter", Dfilter);

                TotalDebits := 0;
                TotalCredits := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    ShowMandatory = true;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        AsAt: Date;
        Dfilter: Text;
        BoldControl: Boolean;
        Debit: Decimal;
        Credit: Decimal;
        StartDate: Date;
        EndDate: Date;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
}

