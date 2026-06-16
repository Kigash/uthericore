codeunit 50017 Automations
{
    procedure ProcessAutomationsInterest(var RunningDate: Date)
    var
        i: Date;
        AutEnt: Record "Automation Log Entries";
        AutEnt2: Record "Automation Log Entries";
        AutEnt3: Record "Automation Log Entries";
        EntryNo: Integer;
    begin

        AutEnt.Reset();
        AutEnt.SetRange("Automation Code", 'LOANINT');
        AutEnt.SetRange("Run Date", RunningDate);
        If AutEnt.FindFirst() then begin
            exit;
        end else begin
            AutEnt3.Reset();
            AutEnt3.SetRange("Automation Code", 'LOANINT');
            If AutEnt3.FindLast() then begin
                If AutEnt3."Next Run Date" <= RunningDate then begin
                    for i := AutEnt3."Next Run Date" to RunningDate do begin
                        RunMonthlyInterest(i);

                        AutEnt2.Reset();
                        If AutEnt2.FindLast() then
                            EntryNo := AutEnt2."Entry No." + 1
                        Else
                            EntryNo := 1;

                        AutEnt2.Init();
                        AutEnt2."Entry No." := EntryNo;
                        AutEnt2."Automation Code" := 'LOANINT';
                        AutEnt2."Run Date" := i;
                        AutEnt2."Next Run Date" := CalcDate('1D', i);
                        AutEnt2.Insert();
                    end;
                end;
            end;
        end;
    end;



    procedure ProcessAutomationsSTO(Var RunningDate: Date)
    var//
        i: Date;
        AutEnt: Record "Automation Log Entries";
        AutEnt2: Record "Automation Log Entries";
        AutEnt3: Record "Automation Log Entries";
        EntryNo: Integer;
    begin
        AutEnt.Reset();
        AutEnt.SetRange("Automation Code", 'STO');
        AutEnt.SetRange("Run Date", RunningDate);
        If AutEnt.FindFirst() then begin
            exit;
        end else begin
            AutEnt3.Reset();
            AutEnt3.SetRange("Automation Code", 'STO');
            If AutEnt3.FindLast() then begin
                If AutEnt3."Next Run Date" <= RunningDate then begin
                    for i := AutEnt3."Next Run Date" to RunningDate do begin
                        If i = CalcDate('-CM', i) then begin
                            RunSTO(i);

                            AutEnt2.Reset();
                            If AutEnt2.FindLast() then
                                EntryNo := AutEnt2."Entry No." + 1
                            Else
                                EntryNo := 1;

                            AutEnt2.Init();
                            AutEnt2."Entry No." := EntryNo;
                            AutEnt2."Automation Code" := 'STO';
                            AutEnt2."Run Date" := i;
                            AutEnt2."Next Run Date" := CalcDate('-CM', CalcDate('1M', i));
                            AutEnt2.Insert();
                        end;
                    end;
                end;
            end;
        end;
    end;

    procedure ProcessAutomationsSTOLocal(RunningDate: Date)
    var
        i: Date;
        AutEnt: Record "Automation Log Entries";
        AutEnt2: Record "Automation Log Entries";
        AutEnt3: Record "Automation Log Entries";
        EntryNo: Integer;
    begin
        AutEnt.Reset();
        AutEnt.SetRange("Automation Code", 'STO');
        AutEnt.SetRange("Run Date", RunningDate);
        If AutEnt.FindFirst() then begin
            exit;
        end else begin
            AutEnt3.Reset();
            AutEnt3.SetRange("Automation Code", 'STO');
            If AutEnt3.FindLast() then begin
                If AutEnt3."Next Run Date" <= RunningDate then begin
                    for i := AutEnt3."Next Run Date" to RunningDate do begin
                        If i = CalcDate('-CM', i) then begin
                            RunSTO(i);

                            AutEnt2.Reset();
                            If AutEnt2.FindLast() then
                                EntryNo := AutEnt2."Entry No." + 1
                            Else
                                EntryNo := 1;

                            AutEnt2.Init();
                            AutEnt2."Entry No." := EntryNo;
                            AutEnt2."Automation Code" := 'STO';
                            AutEnt2."Run Date" := i;
                            AutEnt2."Next Run Date" := CalcDate('-CM', CalcDate('1M', i));
                            AutEnt2.Insert();
                        end;
                    end;
                end;
            end;
        end;
    end;

    Local procedure RunSTO(PostingDate: Date)
    begin
        StandingOrderSetup.Get();
        GlobalSetup.Get();
        TransactionTypeCodeSetup.Get();
        GlobalSetup.TestField("Deposit Minimum Contribution");
        StandingOrderSetup.TestField("Standing Order Template Name");
        StandingOrderSetup.TestField("Standing Order Batch Name");
        JournalTemplateName := StandingOrderSetup."Standing Order Template Name";
        JournalBatchName := StandingOrderSetup."Standing Order Batch Name";
        AccountBalance := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, Vendor."No.");
        GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);

        Member.Reset();
        // Member.SetRange(Category, Member.Category::Individual);
        If Member.FindSet() then begin
            repeat
                AccType.Reset();
                AccType.SetRange(Type, AccType.Type::Savings);
                AccType.SetRange("Sub Type", AccType."Sub Type"::"Field Collection");
                if AccType.FindFirst() then begin
                    Vendor.Reset();
                    Vendor.SetRange("Member No.", Member."No.");
                    Vendor.SetRange("Account Type", AccType.Code);
                    Vendor.SetFilter("Date Filter", '..%1', CalcDate('-1D', PostingDate));
                    if Vendor.FindFirst() then begin
                        RunBal := 0;
                        TotalDeduction := 0;
                        Deposits := 0;

                        Vendor.CalcFields(Balance, "Net Change");
                        RunBal := Vendor."Net Change";
                        Deposits := GlobalSetup."Deposit Minimum Contribution";
                        If RunBal > 0 then begin
                            if StandingOrderSetup."Charge Transaction" then begin
                                if StandingOrderSetup."Charges Calculation Method" = StandingOrderSetup."Charges Calculation Method"::"Flat Amount" then
                                    ChargeAmount := StandingOrderSetup."Charges Value";
                            end;
                            if ChargeAmount >= RunBal then begin
                                ChargeAmount := RunBal;
                                RunBal := 0;
                            end else begin
                                ChargeAmount := ChargeAmount;
                                RunBal := RunBal - ChargeAmount;
                            end;

                            //STO Service Fee****************************************************************************************************
                            if ChargeAmount > 0 then begin
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                        AccountTypeEnum::Vendor, Vendor."No.", 'Service Fee STO- Member No ' + Member."No.", ChargeAmount, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                        AccountTypeEnum::"G/L Account", StandingOrderSetup."Charges G/L Account", 'Service Fee STO- Member No ' + Member."No.", -ChargeAmount, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                            end;
                            //End STO Service Fee****************************************************************************************************

                            //Deduct Member Savings**********************************************************************************
                            if Deposits >= RunBal then begin
                                Deposits := RunBal;
                                RunBal := 0;
                            end else begin
                                Deposits := Deposits;
                                RunBal := RunBal - Deposits;
                            end;

                            If Deposits > 0 then begin
                                AccType3.Reset();
                                AccType3.SetRange(Type, AccType3.Type::"Member Deposit");
                                If AccType3.FindFirst() then begin
                                    Vendor3.Reset();
                                    Vendor3.SetRange("Account Type", AccType3.Code);
                                    Vendor3.SetRange("Member No.", Member."No.");
                                    if Vendor3.FindFirst() then begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                                AccountTypeEnum::Vendor, Vendor."No.", 'STO Minimum savings Contribution Member No ' + Member."No.", Deposits, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                                AccountTypeEnum::Vendor, Vendor3."No.", 'STO Minimum savings Contribution Member No ' + Member."No.", -Deposits, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                    end;
                                end;
                            end;
                            //End Deduct Member Savings**********************************************************************************

                            //Duduct Loans Interest****************************************************************************************************
                            Loan.Reset();
                            Loan.SetCurrentKey("Disbursal Date");
                            Loan.SetRange("Member No.", Member."No.");
                            Loan.SetRange(Posted, true);
                            Loan.SetAscending("Disbursal Date", false);
                            if Loan.FindSet() then begin
                                repeat
                                    Loan.CalcFields("Outstanding Balance");
                                    Cust.Get(Loan."No.");
                                    LProd.Get(Loan."Loan Product Type");
                                    if Loan."Outstanding Balance" > 0 then begin
                                        GlobalManagement.CalculateLoanArrearsSTO(Loan."No.", 0D, CalcDate('-1D', PostingDate), Arrears[1], Arrears[2], Overpayment[1], Overpayment[2]);
                                        if Arrears[2] > 0 then begin
                                            if Arrears[2] >= RunBal then begin
                                                Arrears[2] := RunBal;
                                                RunBal := 0;
                                            end else begin
                                                Arrears[2] := Arrears[2];
                                                RunBal := RunBal - Arrears[2];
                                            end;
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                            AccountTypeEnum::Vendor, Vendor."No.", 'STO Interest Paid Loan No- ' + Loan."No." + ' Member No ' + Member."No.", Arrears[2], '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                            AccountTypeEnum::Customer, Cust."No.", 'STO Interest Paid Loan No- ' + Loan."No." + ' Member No ' + Member."No.", -Arrears[2], LProd."Interest Due Posting Group", TransactionTypeCodeSetup."Interest Paid", SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        end;
                                    end;
                                until Loan.Next = 0;
                            end;
                            //End Duduct Loans Interest************************************************************************************************


                            //Duduct Loans Principal****************************************************************************************************
                            Loan.Reset();
                            Loan.SetCurrentKey("Disbursal Date");
                            Loan.SetRange("Member No.", Member."No.");
                            Loan.SetAscending("Disbursal Date", false);
                            Loan.SetRange(Posted, true);
                            if Loan.FindSet() then begin
                                repeat
                                    Loan.CalcFields("Outstanding Balance");
                                    Cust.Get(Loan."No.");
                                    LProd.Get(Loan."Loan Product Type");
                                    if Loan."Outstanding Balance" > 0 then begin
                                        GlobalManagement.CalculateLoanArrearsSTO(Loan."No.", 0D, CalcDate('-1D', PostingDate), Arrears[1], Arrears[2], Overpayment[1], Overpayment[2]);
                                        LoanSchedule.Reset();
                                        LoanSchedule.SetRange("Loan No.", Loan."No.");
                                        if LoanSchedule.FindFirst() then begin
                                            if Arrears[1] > LoanSchedule."Principal Installment" then
                                                Arrears[1] := Arrears[1]
                                            else
                                                Arrears[1] := LoanSchedule."Principal Installment";
                                        end;
                                        if Arrears[1] > 0 then begin
                                            If Arrears[1] > (Loan."Outstanding Balance" - Arrears[2]) then begin
                                                Arrears[1] := (Loan."Outstanding Balance" - Arrears[2]);
                                            end else begin
                                                Arrears[1] := Arrears[1];
                                            end;

                                            if Arrears[1] >= RunBal then begin
                                                Arrears[1] := RunBal;
                                                RunBal := 0;
                                            end else begin
                                                Arrears[1] := Arrears[1];
                                                RunBal := RunBal - Arrears[1];
                                            end;
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                            AccountTypeEnum::Vendor, Vendor."No.", 'STO Principal Paid Loan No- ' + Loan."No." + ' Member No ' + Member."No.", Arrears[1], '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                            AccountTypeEnum::Customer, Cust."No.", 'STO Principal Paid Loan No- ' + Loan."No." + ' Member No ' + Member."No.", -Arrears[1], LProd.Code, TransactionTypeCodeSetup."Principal Paid", SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        end;
                                    end;
                                until Loan.Next = 0;
                            end;
                            //Duduct Loans Principal************************************************************************************************
                            If RunBal > 0 then begin
                                //Tranfser Remaining Bal To Ordinary Savings************************************************************************************
                                AccType2.Reset();
                                AccType2.SetRange("Sub Type", AccType2."Sub Type"::Ordinary);
                                if AccType2.FindFirst() then begin
                                    Vendor2.Reset();
                                    Vendor2.SetRange("Account Type", AccType2.Code);
                                    Vendor2.SetRange("Member No.", Member."No.");
                                    if Vendor2.FindFirst() then begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                        AccountTypeEnum::Vendor, Vendor."No.", 'STO Field collection Bal Transfer- Member No ' + Member."No.", RunBal, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CalcDate('-1D', PostingDate),
                                        AccountTypeEnum::Vendor, Vendor2."No.", 'STO Field collection Bal Transfer- Member No ' + Member."No.", -RunBal, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                    end;
                                end;
                                //End Tranfser Remaining Bal To Ordinary Savings************************************************************************************
                            end;
                        end;
                    end;
                end;
            until Member.Next = 0;
        end;
        //GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName);

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", JournalTemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", JournalBatchName);
        IF GenJournalLine.FINDSET THEN BEGIN
            COMMIT;
            GenJnlPostBatch.RUN(GenJournalLine);
        END;
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
        "Loan Application".SetFilter("Date Filter", '..%1', RunDate);
        if "Loan Application".FindSet() then begin
            repeat
                GlobalManagement.ClearJournal(LoanApplicationSetup."Loan Interest Template Name", LoanApplicationSetup."Loan Interest Batch Name");
                "Loan Application".CalcFields("Outstanding Balance");
                if "Loan Application"."Outstanding Balance" > 0 then begin
                    Cust.Reset();
                    Cust.SetRange("No.", "Loan Application"."No.");
                    Cust.SetFilter(Status, '<>%1', Cust.Status::Blocked);
                    if Cust.FindFirst() then begin
                        DCustL.Reset();
                        DCustL.SetRange("Customer No.", "Loan Application"."No.");
                        DCustL.SetRange("Transaction Type Code", 'INTDUE');
                        DCustL.SetRange("Posting Date", PostingDate);
                        DCustL.SetRange(Reversed, false);
                        if not DCustL.FindFirst() then begin
                            if "Loan Application"."Date of Completion" > RunDate then begin
                                LoanRep.Reset();
                                LoanRep.SetRange("Loan No.", "Loan Application"."No.");
                                LoanRep.SetRange("Repayment Date", RunDate);
                                if LoanRep.FindFirst() then begin
                                    Customer.Get("Loan Application"."No.");
                                    BOSAManagement.CapitalizeInterest(Customer, RunDate, PostingDate);
                                end;
                            end else begin
                                if (Date2DMY("Loan Application"."Disbursal Date", 1) = Date2DMY(RunDate, 1)) or ((Date2DMY(RunDate, 2) <> Date2DMY(CalcDate('1D', RunDate), 2))
                                    and (Date2DMY("Loan Application"."Disbursal Date", 1) > Date2DMY(RunDate, 1))) then begin
                                    Customer.Get("Loan Application"."No.");
                                    BOSAManagement.CapitalizeInterestExpired(Customer, RunDate, PostingDate);
                                end;
                            end;
                        end;
                    end;
                end;
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", LoanApplicationSetup."Loan Interest Template Name");
                GenJournalLine.SetRange("Journal Batch Name", LoanApplicationSetup."Loan Interest Batch Name");
                if GenJournalLine.FindSet() then begin
                    Commit();
                    GenJnlPostBatch.Run(GenJournalLine)
                end;
            until "Loan Application".Next = 0;
        end;
    end;

    // Local procedure RunMonthlyInterest(PostingDate: Date)
    // begin
    //     RunDate := PostingDate;
    //     LoanApplicationSetup.Get();
    //     LoanApplicationSetup.TestField("Loan Interest Template Name");
    //     LoanApplicationSetup.TestField("Loan Interest Batch Name");
    //     GlobalManagement.ClearJournal(LoanApplicationSetup."Loan Interest Template Name", LoanApplicationSetup."Loan Interest Batch Name");

    //     "Loan Application".Reset();
    //     "Loan Application".SetRange(Posted, true);
    //     "Loan Application".SetRange("Pause Loan Interest", false);
    //     "Loan Application".SetRange("Loan Restructured", false);
    //     if "Loan Application".FindSet() then begin
    //         repeat
    //             "Loan Application".CalcFields("Outstanding Balance");
    //             if "Loan Application"."Outstanding Balance" > 0 then begin
    //                 Cust.Reset();
    //                 Cust.SetRange("No.", "Loan Application"."No.");
    //                 Cust.SetFilter(Status, '<>%1', Cust.Status::Blocked);
    //                 If Cust.FindFirst() then begin
    //                     DCustL.Reset();
    //                     DCustL.SetRange("Customer No.", "Loan Application"."No.");
    //                     DCustL.SetRange("Transaction Type Code", 'INTDUE');
    //                     DCustL.SetRange("Posting Date", PostingDate);
    //                     DCustL.SetRange(Reversed, false);
    //                     If not DCustL.FindFirst() then begin
    //                         if "Loan Application"."Date of Completion" > RunDate then begin
    //                             LoanRep.Reset();
    //                             LoanRep.SetRange("Loan No.", "Loan Application"."No.");
    //                             LoanRep.SetRange("Repayment Date", RunDate);
    //                             If LoanRep.FindFirst() then begin
    //                                 Customer.Get("Loan Application"."No.");
    //                                 BOSAManagement.CapitalizeInterest(Customer, RunDate, PostingDate);
    //                             end;
    //                         end else begin
    //                             if Date2DMY("Loan Application"."Disbursal Date", 1) = Date2DMY(RunDate, 1) then begin
    //                                 Customer.Get("Loan Application"."No.");
    //                                 BOSAManagement.CapitalizeInterestExpired(Customer, RunDate, PostingDate);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             end;
    //         until "Loan Application".Next = 0;
    //     end;
    //     //GlobalManagement.PostJournal(LoanApplicationSetup."Loan Interest Template Name", LoanApplicationSetup."Loan Interest Batch Name");
    //     GenJournalLine.RESET;
    //     GenJournalLine.SETRANGE("Journal Template Name", LoanApplicationSetup."Loan Interest Template Name");
    //     GenJournalLine.SETRANGE("Journal Batch Name", LoanApplicationSetup."Loan Interest Batch Name");
    //     IF GenJournalLine.FINDSET THEN BEGIN
    //         COMMIT;
    //         GenJnlPostBatch.RUN(GenJournalLine);
    //     END;
    // end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        Member: Record Member;
        AccType: Record "Account Type";
        AccType2: Record "Account Type";
        AccType3: Record "Account Type";
        Vendor: Record Vendor;
        Vendor2: Record Vendor;
        Vendor3: Record Vendor;
        StandingOrderSetup: Record "Standing Order Setup";
        JournalTemplateName: Code[50];
        JournalBatchName: Code[50];
        AccountTypeEnum: Enum "Gen. Journal Account Type";
        AccountBalance: Decimal;
        ChargeAmount: Decimal;
        RunBal: Decimal;
        GlobalManagement: Codeunit "Global Management";
        SourceCodeSetup: Record "Source Code Setup";
        BalAccountTypeEnum: Enum "Gen. Journal Account Type";
        AppliesToDocTypeEnum: Enum "Gen. Journal Document Type";
        GlobalSetup: Record "Global Setup";
        TotalDeduction: Decimal;
        Cust: Record Customer;
        Loan: Record "Loan Application";
        Arrears: array[2] of Decimal;
        Overpayment: array[2] of Decimal;
        LProd: Record "Loan Product Type";
        TransactionTypeCodeSetup: Record "Transaction Type Code Setup";
        Deposits: Decimal;
        LoanSchedule: Record "Loan Repayment Schedule";
        Customer: Record Customer;
        Memb: Record Member;
        DCustL: Record "Cust. Ledger Entry";
        "Loan Application": Record "Loan Application";
        i: Integer;
        TotalLoanAccount: Integer;
        BOSAManagement: Codeunit "BOSA Management";
        LoanApplicationSetup: Record "Loan Application Setup";
        LoanApplication: Record "Loan Application";
        DateFormula: DateFormula;
        RunDate: Date;
        PostingDate: Date;
        LoanRep: Record "Loan Repayment Schedule";
}
