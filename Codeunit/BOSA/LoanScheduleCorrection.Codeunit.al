codeunit 59026 "Loan Schedule Correction"
{
    trigger OnRun()
    var
        LoanApplication: Record "Loan Application";
        BOSAManagement: Codeunit "BOSA Management";
        GenJournalLine: Record "Gen. Journal Line";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        GLSetup: Record "General Ledger Setup";
        SourceCodeSetup: Record "Source Code Setup";
        DefaultDim: Record "Default Dimension";
        NoSeriesMgt: Codeunit "No. Series";UserSetup: Record "User Setup";
        LoanAppSetup: Record "Loan Application Setup";
        JournalTemplate: Record "Gen. Journal Template";
        JournalBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        LastLineNo: Integer;
        GLEntry: Record "G/L Entry";
        NextRepaymentDate: Date;
        RepaymentDay: Integer;
    begin
        LoanApplication.Reset();
        LoanApplication.SetFilter(Status, '%1', LoanApplication.Status::Approved);
        LoanApplication.SetRange(Posted, true);
        LoanApplication.SetRange("Schedule Corrected", false);
        if LoanApplication.FindSet() then begin
            repeat
                LoanApplication.CalcFields("Outstanding Balance");
                if LoanApplication."Outstanding Balance" > 0 then begin
                    RepaymentDay := Date2Dmy(LoanApplication."Disbursal Date", 1);
                    if RepaymentDay in [29, 30, 31] then begin
                        // Re-create the repayment schedule
                        BOSAManagement.CreateRepaymentSchedule(LoanApplication."No.", LoanApplication."Approved Amount");
                        LoanApplication."Schedule Corrected" := true;
                        LoanApplication.Modify();
                    end;
                end;
            until LoanApplication.Next() = 0;
        end;
    end;
}