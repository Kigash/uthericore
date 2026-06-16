report 50011 "Loan Listing Report"
{
    ApplicationArea = All;
    Caption = 'Loan Listing Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Report/BOSA/Loan Listing.rdl';
    dataset
    {
        dataitem(LoanApplication; "Loan Application")
        {
            DataItemTableView = WHERE(Posted = FILTER(true));
            RequestFilterFields = "Loan Product Type", "Global Dimension 1 Code", "Member No.", "Disbursal Date";
            column(No; "No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(Description; Description)
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(Church_District_Code; "Church District Code")
            { }
            column(Church_Section_Code; "Church Section Code")
            { }
            column(Church_Code; "Church Code")
            { }
            column(RepaymentPeriod; "Repayment Period")
            {
            }
            column(DisbursalDate; "Disbursal Date")
            {
            }
            column(DateofCompletion; "Date of Completion")
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(ClassificationDesc; ClassificationDesc)
            { }
            column(Arrears; Arrears)
            { }
            trigger OnAfterGetRecord()
            var
                LoanRepSchedule: Record "Loan Repayment Schedule";
                GlobalM: Codeunit "Global Management";
                Amount: array[10] of Decimal;
            begin
                Arrears := 0;
                GlobalM.CalculateLoanArrearsAndOverpayment(LoanApplication."No.", 0D, Today, Amount[1], Amount[2], Amount[3], Amount[4], Amount[5], Amount[6]);
                BOSAManagement.CalculateDaysAndInstallmentsInArrearsDefaulter(LoanApplication."No.", (Amount[1]), NoofDaysInArrears, NoofInstallmentInArrears, Today);
                BOSAManagement.GetClassificationClassDetails(NoofDaysInArrears, ClassificationCode, ClassificationDesc, ProvisioningPercent);
                LoanApplication.CalcFields("Outstanding Balance");
                If LoanApplication."Outstanding Balance" > 0 then
                    Arrears := Amount[1] + Amount[2] + Amount[3] + Amount[4]
                Else
                    Arrears := 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Arrears: Decimal;
        Classification: Code[150];
        BOSAManagement: Codeunit "BOSA Management";
        NoofDaysInArrears: Integer;
        NoofInstallmentInArrears: Integer;
        ClassificationCode: Code[100];
        ClassificationDesc: Text;
        ProvisioningPercent: Decimal;
}
