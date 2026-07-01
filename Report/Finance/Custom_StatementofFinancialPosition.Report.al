
report 59123 "Custom State of Fin. Position"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report\Finance\CustomStatementofFinancialPosition.rdl';
    Caption = 'Statement of Financial Position Custom';
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = where("Income/Balance" = filter("Balance Sheet"));
            column(No_; "No.")
            { }
            column(Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
            { }
            column(Net_Change; "Net Change")
            { }
            column(AsAt; AsAt)
            { }
            column(Bold_control; BoldControl)
            { }
            column(FromDate; FromDate)
            { }
            column(ToDate; ToDate)
            { }

            trigger OnPreDataItem()
            var

            begin
                if ToDate = 0D then
                    ToDate := Today;

                Dfilter := Format(FromDate) + '..' + Format(ToDate);
                SetFilter("Date Filter", Dfilter);
            end;

            trigger OnAfterGetRecord()
            begin
                "G/L Account".CalcFields("Net Change");
                BoldControl := false;
                if ("G/L Account"."Net Change" = 0) and ("G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting) then
                    CurrReport.Skip();
                if ("G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting) then
                    BoldControl := True;
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
                        Visible = false;
                    }
                    field(FromDate; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                        ShowMandatory = true;
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
        AsAt: Date;
        FromDate: Date;
        ToDate: Date;
        Dfilter: Text[100];
        BoldControl: Boolean;
}