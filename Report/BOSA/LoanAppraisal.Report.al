report 50117 "Loan Appraisal Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report\BOSA\LoanAppraisal.rdl';
    dataset
    {
        dataitem("Loan Application"; "Loan Application")
        {
            RequestFilterFields = "No.", "Member No.";

            column(No_; "No.")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Description; Description)
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Interest_Rate; "Interest Rate")
            {

            }
            column(Repayment_Method; "Repayment Method")
            {

            }
            column(Repayment_Frequency; "Repayment Frequency")
            {

            }
            column(Repayment_Period; "Repayment Period")
            {

            }
            column(Total_Deposits_Amount; "Total Deposits Amount")
            {

            }
            column(TotalLoanBalance; TotalLoanBalance)
            {

            }
            column(TopupAmount; TopupAmount)
            {

            }
            column(TotalGuarantorsAmount; TotalGuarantorsAmount)
            {

            }
            column(TotalCollateralAmount; TotalCollateralAmount)
            {

            }
            column(ProcessingFee; ProcessingFee)
            {

            }
            column(InsuranceFee; InsuranceFee)
            {

            }
            column(LegalFee; LegalFee)
            {

            }
            column(CRBFee; CRBFee)
            {

            }
            column(WFee; WFee)
            {

            }
            column(RFee; RFee)
            {

            }
            column(TotalDeductions; TotalDeductions)
            {

            }
            column(QualifyingAmount; QualifyingAmount)
            {

            }

            column(Created_Date; "Created Date")
            {

            }
            column(Created_By; "Created By")
            {

            }
            column(Appraisal_Date; "Appraisal Date")
            {

            }
            column(Appraised_By; "Appraised By")
            {

            }
            column(Approved_By; "Approved By")
            {

            }
            column(Approved_Date; "Approved Date")
            {

            }
            column(No__of_Guarantors; "No. of Guarantors")
            {

            }
            column(Loan_Deposits_Ratio; "Loan Deposits Ratio")
            {

            }
            column(Max__Eligible_Amount_Deposit; "Max. Eligible Amount-Deposit")
            {

            }
            column(Total_Savings_Amount; "Total Savings Amount")
            {

            }
            column(Loan_Savings_Ratio; "Loan Savings Ratio")
            {

            }
            column(Max__Eligible_Amount_Savings; "Max. Eligible Amount-Savings")
            {

            }
            column(Total_Shares_Amount; "Total Shares Amount")
            {

            }
            column(Loan_Shares_Ratio; "Loan Shares Ratio")
            {

            }
            column(Max__Eligible_Amount_Shares; "Max. Eligible Amount-Shares")
            {

            }
            column(PayableInstallment; PayableInstallment)
            {

            }
            column(CompInfo_Picture; CompInfo.Picture)
            {

            }
            column(CompInfo_Name; CompInfo.Name)
            {

            }
            column(Remarks; Remarks)
            {

            }
            dataitem("Loan Guarantor"; "Loan Guarantor")
            {
                DataItemLink = "Loan No." = field("No.");
                column(Member_No_2; "Member No.")
                {

                }
                column(Member_Name2; "Member Name")
                {

                }
                column(Account_No_; "Account No.")
                {

                }
                column(Account_Name; "Account Name")
                {

                }
                column(Amount_To_Guarantee; "Amount To Guarantee")
                {

                }

            }
            dataitem("Loan Collateral"; "Loan Collateral")
            {
                DataItemLink = "Loan No." = field("No.");
                column(Security_Type_Code; "Security Type Code")
                {

                }
                column(Security_Register_Code; "Security Register Code")
                {

                }
                column(Description2; Description)
                {

                }
                column(Security_Value; "Security Value")
                {

                }
                column(Security_Factor; "Security Factor")
                {

                }
                column(Guaranteed_Amount; "Guaranteed Amount")
                {

                }

            }
            dataitem("Loan Refinancing Entry"; "Loan Refinancing Entry")
            {
                DataItemLink = "Loan No." = field("No.");
                column(Description3; Description)
                {

                }
                column(Outstanding_Balance; "Outstanding Balance")
                {

                }
                column(TopUpCharge; TopUpCharge)
                {

                }
                trigger OnPreDataItem()
                begin
                    RFee := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    TopUpCharge := 0;
                    LoanAppSetup.Get();
                    if LoanAppSetup."Topup Charge Method" = LoanAppSetup."Topup Charge Method"::"% of Outstanding Loan" then begin
                        TopUpCharge := "Loan Refinancing Entry"."Outstanding Balance" * (LoanAppSetup."TopUp Charge Value" / 100);
                    end;
                    if LoanAppSetup."Topup Charge Method" = LoanAppSetup."Topup Charge Method"::"Flat Amount" then begin
                        TopUpCharge := LoanAppSetup."TopUp Charge Value";
                    end;
                end;
            }


            trigger OnAfterGetRecord()
            var
                Installments: Integer;
                BosaM: Codeunit "BOSA Management";
                StartDate: Date;

            begin
                TopupAmount := 0;
                CalcFields("No. of Guarantors");
                TotalLoanBalance := BOSAManagement.CalculateOtherLoanBalances("Member No.");
                CalculateTopUpLoan("No.");
                CalculateTotalGuarantorsAmount("No.");
                CalculateTotalCollateralAmount("No.");
                if "Disbursal Date" = 0D then begin
                    StartDate := "Created Date";
                end else begin
                    StartDate := "Disbursal Date";
                end;

                Installments := BosaM.GetNoofInstallments("No.", StartDate, "Date of Completion");
                CalculateFees("Loan Product Type", "Requested Amount", Installments);
                TotalDeductions := InsuranceFee + ProcessingFee + LegalFee + CRBFee + TopupAmount;

                if (TotalGuarantorsAmount + TotalCollateralAmount) > "Requested Amount" then
                    QualifyingAmount := "Requested Amount"
                else
                    QualifyingAmount := (TotalGuarantorsAmount + TotalCollateralAmount);
                GetPayableInstallment("No.");
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
                {/* 
                    field(Name; SourceExpression)
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


    local procedure CalculateTopUpLoan(LoanNo: Code[20])
    var
        LoanRefinancingEntry: Record "Loan Refinancing Entry";
    begin
        LoanRefinancingEntry.Reset();
        LoanRefinancingEntry.SetRange("Loan No.", LoanNo);
        LoanRefinancingEntry.SetRange(Select, true);
        LoanRefinancingEntry.CalcSums(LoanRefinancingEntry."Outstanding Balance");
        TopupAmount := LoanRefinancingEntry."Outstanding Balance";
        LoanAppSetup.Get();
        if LoanAppSetup."Topup Charge Method" = LoanAppSetup."Topup Charge Method"::"% of Outstanding Loan" then begin
            RFee := LoanRefinancingEntry."Outstanding Balance" * (LoanAppSetup."TopUp Charge Value" / 100);
        end;
        if LoanAppSetup."Topup Charge Method" = LoanAppSetup."Topup Charge Method"::"Flat Amount" then begin
            RFee := LoanAppSetup."TopUp Charge Value";
        end;
        TopupAmount := TopupAmount + RFee;
    end;

    local procedure CalculateTotalGuarantorsAmount(LoanNo: Code[20])
    var
        LoanGuarantor: Record "Loan Guarantor";
    begin
        LoanGuarantor.Reset();
        LoanGuarantor.SetRange("Loan No.", LoanNo);
        LoanGuarantor.CalcSums("Amount To Guarantee");
        TotalGuarantorsAmount := LoanGuarantor."Amount To Guarantee";
    end;

    local procedure CalculateTotalCollateralAmount(LoanNo: Code[20])
    var
        LoanCollateral: Record "Loan Collateral";
    begin
        LoanCollateral.Reset();
        LoanCollateral.SetRange("Loan No.", LoanNo);
        LoanCollateral.CalcSums("Guaranteed Amount");
        TotalCollateralAmount := LoanCollateral."Guaranteed Amount";
    end;

    local procedure CalculateFees(LoanProductType: Code[20]; LoanAmount: Decimal; Instalments: Integer)
    var
        LoanProductTypeRec: Record "Loan Product Type";
        LoanProductCharge: Record "Loan Product Charge";
        LoanChargeSetup: Record "Loan Charge Setup";
        BosaM: Codeunit "BOSA Management";
    begin
        ProcessingFee := 0;
        InsuranceFee := 0;
        LegalFee := 0;
        CRBFee := 0;
        LoanProductTypeRec.Get(LoanProductType);
        LoanProductCharge.Reset();
        LoanProductCharge.SetRange("Loan Product Type", LoanProductType);
        IF LoanProductCharge.FindSet() THEN begin
            repeat
                LoanChargeSetup.Get(LoanProductCharge.Code);
                IF LoanChargeSetup.Type = LoanChargeSetup.Type::"Processing Fee" then begin
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"Flat Amount" then
                        ProcessingFee := LoanProductCharge.Value;
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"% of Loan" then
                        ProcessingFee := LoanProductCharge.Value / 100 * LoanAmount;
                end;
                IF LoanChargeSetup.Type = LoanChargeSetup.Type::"Insurance Fee" then begin
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"Flat Amount" then
                        InsuranceFee := LoanProductCharge.Value;
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"% of Loan" then
                        InsuranceFee := (LoanProductCharge.Value * LoanAmount) / 100;
                end;
                IF LoanChargeSetup.Type = LoanChargeSetup.Type::"Legal Fee" then begin
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"Flat Amount" then
                        LegalFee := LoanProductCharge.Value;
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"% of Loan" then
                        LegalFee := (LoanProductCharge.Value * LoanAmount) / 100;
                end;
                IF LoanChargeSetup.Type = LoanChargeSetup.Type::"CRB Fee" then begin
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"Flat Amount" then
                        CRBFee := LoanProductCharge.Value;
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"% of Loan" then
                        CRBFee := (LoanProductCharge.Value * LoanAmount) / 100;
                end;
                IF LoanChargeSetup.Type = LoanChargeSetup.Type::"Withdrawal Fee" then begin
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"Flat Amount" then
                        WFee := LoanProductCharge.Value;
                    if LoanProductCharge."Calculation Mode" = LoanProductCharge."Calculation Mode"::"% of Loan" then
                        WFee := (LoanProductCharge.Value * LoanAmount) / 100;
                end;
            UNTIL LoanProductCharge.Next() = 0;
        end;

    end;

    local procedure GetPayableInstallment(LoanNo: Code[20])
    var

    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
        if LoanRepaymentSchedule.FindFirst() then
            PayableInstallment := LoanRepaymentSchedule."Principal Installment" + LoanRepaymentSchedule."Interest Installment";

    end;

    trigger OnPreReport()
    var

    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        TotalLoanBalance: Decimal;
        TopupAmount: Decimal;
        TotalGuarantorsAmount: Decimal;
        TotalCollateralAmount: Decimal;
        ProcessingFee: Decimal;
        InsuranceFee: Decimal;
        LegalFee: Decimal;
        CRBFee: Decimal;
        WFee: Decimal;
        RFee: Decimal;
        TotalDeductions: Decimal;
        QualifyingAmount: Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        PayableInstallment: Decimal;
        BOSAManagement: Codeunit "BOSA Management";
        Member: Record Member;
        TopUpCharge: Decimal;
        LoanAppSetup: Record "Loan Application Setup";
}