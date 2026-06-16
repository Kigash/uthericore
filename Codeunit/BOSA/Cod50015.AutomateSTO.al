codeunit 50015 AutomateSTO
{
    var
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

    trigger OnRun()
    begin
        RunSTO();
    end;
    //end;
    procedure RunSTO()
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

        If Today = CalcDate('-CM', Today) then begin //To Run every endmonth
            Member.Reset();
            //Member.SetRange("No.", '018508');
            Member.SetRange(Category, Member.Category::Individual);
            If Member.FindSet() then begin
                repeat
                    AccType.Reset();
                    AccType.SetRange(Type, AccType.Type::Savings);
                    AccType.SetRange("Sub Type", AccType."Sub Type"::"Field Collection");
                    if AccType.FindFirst() then begin
                        Vendor.Reset();
                        Vendor.SetRange("Member No.", Member."No.");
                        Vendor.SetRange("Account Type", AccType.Code);
                        Vendor.SetFilter("Date Filter", '..%1', CALCDATE('CM', CalcDate('-1M', TODAY)));
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
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
                                            AccountTypeEnum::Vendor, Vendor."No.", 'Service Fee STO-' + ' Member No ' + Member."No.", ChargeAmount, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
                                            AccountTypeEnum::"G/L Account", StandingOrderSetup."Charges G/L Account", 'Service Fee STO-' + ' Member No ' + Member."No.", -ChargeAmount, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
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
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
                                                    AccountTypeEnum::Vendor, Vendor."No.", 'STO Minimum savings Contribution' + ' Member No ' + Member."No.", Deposits, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
                                                    AccountTypeEnum::Vendor, Vendor3."No.", 'STO Minimum savings Contribution' + ' Member No ' + Member."No.", -Deposits, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
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
                                            GlobalManagement.CalculateLoanArrearsSTO(Loan."No.", 0D, Today, Arrears[1], Arrears[2], Overpayment[1], Overpayment[2]);
                                            if Arrears[2] > 0 then begin
                                                if Arrears[2] >= RunBal then begin
                                                    Arrears[2] := RunBal;
                                                    RunBal := 0;
                                                end else begin
                                                    Arrears[2] := Arrears[2];
                                                    RunBal := RunBal - Arrears[2];
                                                end;
                                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
                                                AccountTypeEnum::Vendor, Vendor."No.", 'STO Interest Paid Loan No- ' + Loan."No." + ' Member No ' + Member."No.", Arrears[2], '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
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
                                            GlobalManagement.CalculateLoanArrearsSTO(Loan."No.", 0D, Today, Arrears[1], Arrears[2], Overpayment[1], Overpayment[2]);
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
                                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
                                                AccountTypeEnum::Vendor, Vendor."No.", 'STO Principal Paid Loan No- ' + Loan."No." + ' Member No ' + Member."No.", Arrears[1], '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
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
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
                                            AccountTypeEnum::Vendor, Vendor."No.", 'STO Field collection Bal Transfer- Member No ' + Member."No.", RunBal, '', '', SourceCodeSetup."Standing Order", GlobalManagement.GetBranchCode(Member."No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, 'STO', 'STO', CALCDATE('CM', CalcDate('-1M', TODAY)),
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
            GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName);
        end;
    end;
}
