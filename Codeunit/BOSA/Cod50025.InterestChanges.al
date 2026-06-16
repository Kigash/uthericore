codeunit 50025 "Interest Changes"
{
    var
        Text000: Label 'Processing Interest..\';
        Text001: Label 'Member No.   #1#############################\';
        Text002: Label 'Member Name  #2#############################\';
        Text003: Label 'Loan No.     #3#############################\\';
        Text004: Label 'Description  #4#############################\';
        Text005: Label 'Progress          @5@@@@@@@@@@@@@@@@@@@@@@@\';
        Text007: Label 'Posting failed';
        Text008: Label 'Kindly indicate interest run date';
        ProgressWindow: Dialog;
        TotalLoanAccount: Integer;
        BOSAManagement: Codeunit "BOSA Management";
        GlobalManagement: Codeunit "Global Management";
        LoanApplicationSetup: Record "Loan Application Setup";
        LoanApplication: Record "Loan Application";
        DateFormula: DateFormula;
        RunDate: Date;

        PostingDate: Date;
        LoanRep: Record "Loan Repayment Schedule";
        "Loan Application": Record "Loan Application";
        SourceCodeSetup: Record "Source Code Setup";
        TransactionTypeCodeSetup: Record "Transaction Type Code Setup";
        LoanProductType: Record "Loan Product Type";
        AccountTypeEnum: Enum "Gen. Journal Account Type";
        BalAccountTypeEnum: Enum "Gen. Journal Account Type";
        AppliesToDocTypeEnum: Enum "Gen. Journal Document Type";
        Customer: Record Customer;
        DocNo: Code[200];
        DocNoExp: Code[200];
        CustL: Record "Cust. Ledger Entry";
        DCustL: Record "Cust. Ledger Entry";
        GLedgerE: Record "G/L Entry";
        i: Date;
        Cust: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";

    trigger OnRun()
    begin
        LoanApplicationSetup.Get();
        LoanApplicationSetup.TestField("Loan Interest Template Name");
        LoanApplicationSetup.TestField("Loan Interest Batch Name");
        SourceCodeSetup.GET;
        TransactionTypeCodeSetup.Get();
        SourceCodeSetup.TestField(Loan);
        LoanApplicationSetup.TestField("Loan Disbursal Template Name");
        LoanApplicationSetup.TestField("Loan Disbursal Batch Name");
        TransactionTypeCodeSetup.TestField("New Loan");
        TransactionTypeCodeSetup.TestField("Processing Fee");
        TransactionTypeCodeSetup.TestField("Insurance Fee");
        TransactionTypeCodeSetup.TestField("Refinancing Fee");

        PostingDate := 0D;
        DocNo := '';
        DocNoExp := '';
        PostingDate := Today;
        For i := 20230401D to PostingDate do begin
            RunMonthlyInterest(i);
        end;
        Message('Update Complete');

    end;

    Local procedure RunMonthlyInterest(PostingDate: Date)
    begin
        RunDate := PostingDate;
        LoanApplicationSetup.Get();
        LoanApplicationSetup.TestField("Loan Interest Template Name");
        LoanApplicationSetup.TestField("Loan Interest Batch Name");


        "Loan Application".Reset();
        "Loan Application".SetRange(Posted, true);
        "Loan Application".SetRange("Pause Loan Interest", false);
        "Loan Application".SetRange("Loan Restructured", false);
        if "Loan Application".FindSet() then begin
            repeat

            until "Loan Application".Next = 0;
        end;
        //GlobalManagement.PostJournal(LoanApplicationSetup."Loan Interest Template Name", LoanApplicationSetup."Loan Interest Batch Name");

    end;

    procedure ClearTransactions(PostingDate: Date)
    begin
        DocNo := '';
        DocNoExp := '';
        For i := CalcDate('-5D', PostingDate) to PostingDate do begin
            DocNo := 'INT_' + FORMAT(i);
            DocNoExp := 'INT_EX' + FORMAT(i);

            DCustL.Reset();
            DCustL.SetRange("Document No.", DocNo);
            DCustL.SetRange("Posting Date", i);
            If DCustL.FindSet() then begin
                DCustL.DeleteAll();
            end;
            CustL.Reset();
            CustL.SetRange("Document No.", DocNo);
            CustL.SetRange("Posting Date", i);
            If CustL.FindSet() then begin
                CustL.DeleteAll();
            end;
            GLedgerE.Reset();
            GLedgerE.SetRange("Document No.", DocNo);
            GLedgerE.SetRange("Posting Date", i);
            if GLedgerE.FindSet() then begin
                GLedgerE.DeleteAll();
            end;
            DCustL.Reset();
            DCustL.SetRange("Document No.", DocNoExp);
            DCustL.SetRange("Posting Date", i);
            If DCustL.FindSet() then begin
                DCustL.DeleteAll();
            end;
            CustL.Reset();
            CustL.SetRange("Document No.", DocNoExp);
            CustL.SetRange("Posting Date", i);
            If CustL.FindSet() then begin
                CustL.DeleteAll();
            end;
            GLedgerE.Reset();
            GLedgerE.SetRange("Document No.", DocNoExp);
            GLedgerE.SetRange("Posting Date", i);
            if GLedgerE.FindSet() then begin
                GLedgerE.DeleteAll();
            end;
        end;
        Message('Update Complete');
    end;

}
