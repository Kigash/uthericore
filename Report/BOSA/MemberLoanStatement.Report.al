report 50081 "Member Loan Statement"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report/BOSA/Member Loan Statement.rdl';

    dataset
    {
        dataitem(Member; Member)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(No_Member; "No.")
            {
            }
            column(Surname_Member; Surname)
            {
            }
            column(FullName_Member; "Full Name")
            {
            }
            column(GlobalDimension1Code_Member; "Global Dimension 1 Code")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(Phone_No_; "Phone No.")
            {
            }
            column(National_ID; "National ID")
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            dataitem(LoanApplication; "Loan Application")
            {
                RequestFilterFields = "No.", "Loan Product Type";
                DataItemLink = "Member No." = FIELD("No.");
                DataItemTableView = WHERE(Posted = FILTER(true));
                column(No_LoanApplication; "No.")
                {
                }
                column(MemberNo_LoanApplication; "Member No.")
                {
                }
                column(MemberName_LoanApplication; "Member Name")
                {
                }
                column(LoanProductType_LoanApplication; "Loan Product Type")
                {
                }
                column(Description_LoanApplication; Description)
                {
                }
                column(InterestRate_LoanApplication; "Interest Rate")
                {
                }
                column(RepaymentPeriod_LoanApplication; "Repayment Period")
                {
                }
                column(RepaymentMethod_LoanApplication; "Repayment Method")
                {
                }
                column(RequestedAmount_LoanApplication; "Requested Amount")
                {
                }
                column(ApprovedAmount_LoanApplication; "Approved Amount")
                {
                }
                column(TotalSavingsAmount_LoanApplication; "Total Savings Amount")
                {
                }
                column(Outstanding_Balance; "Outstanding Balance")
                {
                }
                column(Date_of_Completion; "Date of Completion")
                {
                }
                column(OutstandingBalance; CalcOutstandingBalance)
                {
                }
                column(PayableInstallment; PayableInstallment)
                {
                }
                column(BalanceBF; BalanceBF)
                {
                }
                dataitem(CustLedgerEntry; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No.");
                    DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                    column(CustomerNo_CustLedgerEntry; "Customer No.")
                    {
                    }
                    column(PostingDate_CustLedgerEntry; "Posting Date")
                    {
                    }
                    column(DocumentType_CustLedgerEntry; "Document Type")
                    {
                    }
                    column(DocumentNo_CustLedgerEntry; "Document No.")
                    {
                    }
                    column(Description_CustLedgerEntry; Description)
                    {
                    }
                    column(CurrencyCode_CustLedgerEntry; "Currency Code")
                    {
                    }
                    column(Amount_CustLedgerEntry; Amount)
                    {
                    }
                    column(RemainingAmount_CustLedgerEntry; "Remaining Amount")
                    {
                    }
                    column(RunningBalance; RunningBalance)
                    {
                    }
                    column(Debit_Amount; "Debit Amount")
                    {
                    }
                    column(Credit_Amount; "Credit Amount")
                    {
                    }
                    column(Reversed; Reversed)
                    {
                    }
                    trigger OnPreDataItem()
                    begin

                        if (StartDate <> 0D) or (EndDate <> 0D) THEN
                            SetRange("Posting Date", StartDate, EndDate);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        if Reversed then
                            CurrReport.Skip();

                        RunningBalance += Amount;
                    end;

                }
                trigger OnAfterGetRecord()
                begin
                    GetPayableInstallment("No.");
                    CalculateBalanceBF("No.");
                    RunningBalance := BalanceBF;

                    // "Outstanding Balance" := CalculateOutstandingBalanceAsAt("No.");
                    CalcOutstandingBalance := CalculateOutstandingBalanceAsAt("No.");

                end;
            }
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
                }
                // field(AsAt; EndDate)
                // {
                //     ApplicationArea = All;
                //     Caption = 'As at';
                // }
            }
        }
    }

    labels
    {
        ReportTitle = 'Loan Statement';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);

        if StartDate = 0D then begin
            CustLedgerEntry.Reset();
            if CustLedgerEntry.FindFirst() then
                StartDate := CustLedgerEntry."Posting Date";
        end;

        if EndDate = 0D then begin
            CustLedgerEntry.Reset();
            if CustLedgerEntry.FindLast() then
                EndDate := CustLedgerEntry."Posting Date";
        end;
    end;

    local procedure GetPayableInstallment(LoanNo: Code[20])
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
        if LoanRepaymentSchedule.FindFirst() then
            PayableInstallment := LoanRepaymentSchedule."Principal Installment" + LoanRepaymentSchedule."Interest Installment"
        else
            PayableInstallment := 0;
    end;

    local procedure CalculateBalanceBF(LoanNo: Code[20])
    var
        LoanApp: Record "Loan Application";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        FirstPostingDate: Date;
    begin
        BalanceBF := 0;
        LoanApp.Reset();
        LoanApp.SetRange("No.", LoanNo);


        if StartDate <> 0D then
            LoanApp.SetFilter("Date Filter", '..%1', StartDate - 1);

        if LoanApp.FindFirst() then begin
            LoanApp.CalcFields("Outstanding Balance");
            BalanceBF := LoanApp."Outstanding Balance";
        end;
    end;

    local procedure CalculateOutstandingBalanceAsAt(LoanNo: Code[20]): Decimal
    var
        LoanApp: Record "Loan Application";
    begin
        LoanApp.Reset();
        LoanApp.SetRange("No.", LoanNo);

        if EndDate <> 0D then
            LoanApp.SetFilter("Date Filter", '..%1', EndDate);

        if LoanApp.FindFirst() then begin
            LoanApp.CalcFields("Outstanding Balance");
            exit(LoanApp."Outstanding Balance");
        end;

        exit(0);
    end;



    var
        CompanyInfo: Record "Company Information";
        RunningBalance: Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        PayableInstallment: Decimal;
        StartDate: Date;
        EndDate: Date;
        BalanceBF: Decimal;
        CalcOutstandingBalance: Decimal;
        LastPostingDate: Date;
}