page 50356 "Branch Analysis-LProduct Chart"
{
    Caption = 'Loan Product Types Analysis';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Status Text';
                Editable = false;
                ShowCaption = false;
                ToolTip = 'Specifies the status of the chart.';
            }
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = Basic, Suite;

                trigger DataPointClicked(point: JsonObject)
                begin
                    //        SetDrillDownIndexes(point);
                    TrailingLoanProductMgt.DrillDown(Rec);
                end;

                // trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                // begin
                // end;


                trigger AddInReady()
                begin
                    IsChartAddInReady := true;
                    TrailingLoanProductMgt.OnOpenPage(TrailingLoanProductSetup);
                    UpdateStatus;
                    if IsChartDataReady then
                        UpdateChart;
                end;

                trigger Refresh()
                begin
                    if IsChartAddInReady and IsChartDataReady then begin
                        NeedsUpdate := true;
                        UpdateChart
                    end;
                end;
            }
        }
    }



    trigger OnFindRecord(Which: Text): Boolean
    begin
        UpdateChart;
        IsChartDataReady := true;

        if not IsChartAddInReady then;
    end;

    trigger OnOpenPage()
    begin
        ;
    end;

    var
        TrailingLoanProductSetup: Record "Trailing Loan Product Setup";
        OldTrailingLoanProductSetup: Record "Trailing Loan Product Setup";
        TrailingLoanProductMgt: Codeunit "Trailing Loan Products Mgt.";
        StatusText: Text[250];
        NeedsUpdate: Boolean;
        [InDataSet]

        IsChartAddInReady: Boolean;
        IsChartDataReady: Boolean;

    local procedure UpdateChart()
    begin
        if not NeedsUpdate then
            exit;
        if not IsChartAddInReady then
            exit;
        TrailingLoanProductMgt.UpdateData(Rec);
        // Update(CurrPage.BusinessChart);
        UpdateStatus;
        NeedsUpdate := false;
    end;

    local procedure UpdateStatus()
    begin
        NeedsUpdate :=
          NeedsUpdate or
          (OldTrailingLoanProductSetup."Chart Type" <> TrailingLoanProductSetup."Chart Type");

        OldTrailingLoanProductSetup := TrailingLoanProductSetup;

        if NeedsUpdate then;
        //  StatusText := TrailingLoanProductSetup.GetCurrentSelectionText;

    end;

    local procedure RunSetup()
    begin
        // PAGE.RunModal(PAGE::"Trailing Members Setup", TrailingLoanProductSetup);
        TrailingLoanProductSetup.Get(UserId);
        UpdateStatus;
    end;
}