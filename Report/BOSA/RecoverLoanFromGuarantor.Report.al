report 57050 "RecoverLoanFromGuarantor"
{
    // version TL2.0

    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1; "Loan Application")
        {
            DataItemTableView = WHERE(Posted = FILTER(true));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                LoaneeDepAcc: Code[50];
                AccType: Record "Account Type";
            begin
                SourceCodeSetup.Get();
                GlobalSetup.Get();
                TransactionTypeCodeSetup.Get();
                SourceCodeSetup.TestField("Loan Recovery");
                RunningBal := 0;
                AmountToRecover := 0;

                LoanApplication.Get("No.");
                LoanApplication.CalcFields("Outstanding Balance");
                RunningBal := LoanApplication."Outstanding Balance";

                LoanGuarantor.RESET;
                LoanGuarantor.SETRANGE("Loan No.", LoanApplication."No.");
                IF LoanGuarantor.FINDSET THEN BEGIN
                    LoanGuarantor.CalcSums("Amount To Guarantee");
                    TotalGuarAmount := LoanGuarantor."Amount To Guarantee";
                END;

                AmountToRecover := RunningBal;

                AccType.Reset();
                AccType.SetRange(Type, AccType.Type::"Member Deposit");
                If AccType.FindFirst() then begin
                    Vendor.Reset();
                    Vendor.SetRange("Account Type", AccType.Code);
                    Vendor.SetRange("Member No.", LoanApplication."Member No.");
                    If Vendor.FindFirst() then begin
                        Vendor.CalcFields(Balance);
                        if Vendor.Balance > AmountToRecover then
                            AmountToRecover := AmountToRecover
                        else
                            AmountToRecover := Vendor.Balance;
                        GlobalManagement.DeductLoanArrearsGuarRecovery(TransactionTypeCodeSetup, SourceCodeSetup, JournalTemplateName, JournalBatchName, "No.", '', Today, DataItem1."No.", AmountToRecover, "Global Dimension 1 Code", LoanGuarantor."Account No.");
                        RunningBal := RunningBal - AmountToRecover;
                    end;
                END;

                if RunningBal > 0 then begin
                    LoanGuarantor.RESET;
                    LoanGuarantor.SETRANGE("Loan No.", LoanApplication."No.");
                    LoanGuarantor.SetFilter("Member No.", '<>%1', LoanApplication."Member No.");
                    IF LoanGuarantor.FINDSET THEN BEGIN
                        REPEAT
                            AmountToRecover := 0;
                            LoanGuarantor.TestField("Member No.");
                            LoanGuarantor.TestField("Account No.");
                            LoanGuarantor.TestField("Amount To Guarantee");
                            AmountToRecover := (LoanGuarantor."Amount To Guarantee" / TotalGuarAmount) * RunningBal;
                            GlobalManagement.DeductLoanArrearsGuarRecovery(TransactionTypeCodeSetup, SourceCodeSetup, JournalTemplateName, JournalBatchName, "No.", '', Today, DataItem1."No.", AmountToRecover, "Global Dimension 1 Code", LoanGuarantor."Account No.");
                        UNTIL LoanGuarantor.NEXT = 0;
                    END;
                end;
            end;

            trigger OnPostDataItem()
            begin
                GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName);
            end;

            trigger OnPreDataItem()
            begin
                LoanAppSetup.Get();
                JournalTemplateName := LoanAppSetup."Loan Recovery Template Name";
                JournalBatchName := LoanAppSetup."Loan Recovery Batch Name";
                GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }



    var
        Descrp: Text[250];
        LoanGuarantor: Record "Loan Guarantor";
        LoanApplication2: Record "Loan Application";
        LoanProductType: Record "Loan Product Type";
        Text000: Label 'Defaulter Loan';
        LoanApplication: Record "Loan Application";
        TotalGuarAmount: Decimal;
        Vendor: record Vendor;
        AmountToRecover: Decimal;
        RunningBal: Decimal;
        LoanAppSetup: Record "Loan Application Setup";
        GlobalSetup: Record "Global Setup";
        SourceCodeSetup: Record "Source Code Setup";
        BOSAManagement: Codeunit "BOSA Management";
        ProgressWindow: Dialog;
        TransactionTypeCodeSetup: Record "Transaction Type Code Setup";
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        GlobalManagement: Codeunit "Global Management";
        i: Integer;
        TotalLoan: Integer;
        Text001: Label 'Member No.      #1#############################\';
        Text002: Label 'Member Name  #2#############################\';
        Text003: Label 'Loan No.          #3#############################\\';
        Text004: Label 'Description       #4#############################\';
        Text005: Label 'Progress          @5@@@@@@@@@@@@@@@@@@@@@@@\';
        Text006: Label 'Attaching Loan to Guarantors\';
        LoanDefaulterSetup: Record "Loan Defaulter Setup";
}

