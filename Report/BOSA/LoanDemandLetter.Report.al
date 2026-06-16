report 57212 "Loan Demand Letter"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report/BOSA/LoanDemandLetter.rdl';
    dataset
    {
        dataitem("Loan Application"; "Loan Application")
        {
            //  DataItemTableView = where(Posted = filter(true));

            column(CompPicture; CompInfo.Picture)
            {

            }
            column(CompName; CompInfo.Name)
            {

            }
            column(No_; "No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; Uppercase("Member Name"))
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Description; Description)
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Repayment_Period; "Repayment Period")
            {

            }
            column(RepaymentAmount; Round(RepaymentAmount))
            {

            }
            column(loanPurpose; loanPurpose)
            {

            }
            column(Interest_Rate; "Interest Rate")
            {

            }
            column(Created_By; "Created By")
            {

            }
            column(Created_Date; "Created Date")
            {

            }
            column(Appraised_By; "Appraised By")
            {

            }
            column(Appraisal_Date; "Appraisal Date")
            {

            }
            column(Approved_By; "Approved By")
            {

            }
            column(Approved_Date; "Approved Date")
            {

            }
            column(Disbursed_By; "Disbursed By")
            {

            }
            column(Disbursal_Date; "Disbursal Date")
            {

            }
            column(AmountInWords; AmountInWords)
            {

            }
            column(Outstanding_Balance; "Outstanding Balance")
            { }
            column(TotalArrears; TotalArrears)
            { }
            trigger OnAfterGetRecord()
            var

            begin
                AmountInWords := UpperCase(GlobalManagement.GetAmountInWords("Approved Amount"));
                if EcSubSector.Get("Economic Sector Sub-Category") then
                    loanPurpose := EcSubSector.Description;

                RepaySched.Reset();
                RepaySched.SetRange("Loan No.", "No.");
                if RepaySched.FindFirst() then begin
                    RepaymentAmount := RepaySched."Total Installment";

                end;
                TotalArrears := 0;
                GlobalM.CalculateLoanArrearsAndOverpayment("No.", 0D, Today, ArrearaAmount[1], ArrearaAmount[2], ArrearaAmount[3], ArrearaAmount[4], Overpay[1], Overpay[2]);
                TotalArrears := ArrearaAmount[1] + ArrearaAmount[2] + ArrearaAmount[3] + ArrearaAmount[4];
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    /*  field(NO)
                     {
                         ApplicationArea = All;

                     } */
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

    begin
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;

    var
        LoanProductTpe: Record "Loan Product Type";
        GlobalM: Codeunit "Global Management";
        ArrearaAmount: array[5] of Decimal;
        Overpay: array[3] of Decimal;
        TotalArrears: Decimal;
        CompInfo: Record "Company Information";
        GlobalManagement: Codeunit "Global Management";
        LoanDefSetup: Record "Loan Defaulter Setup";
        NoOfDaysInArrears: Decimal;
        AmountInWords: Text[250];
        RepaymentAmount: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        loanPurpose: text;
        EcSubSector: Record "Economic Sector Sub-Category";
}