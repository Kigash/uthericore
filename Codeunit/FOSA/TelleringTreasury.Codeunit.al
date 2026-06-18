codeunit 50004 "Tellering & Treasury"
{
    trigger OnRun()
    begin

    end;

    procedure PostTellerTransaction(var TellerTransactionHeader: Record "Teller Transaction Header")
    var
        TellerTransactionLine: Record "Teller Transaction Line";
        ArrearsAmount: array[4] of Decimal;
        OverpaymentAmount: array[4] of Decimal;
        InstallmentDue: array[4] of Decimal;
        RemainingAmount: Decimal;
        ChargeAmount: array[8] of Decimal;
        AccountBalance: Decimal;
    begin
        WITH TellerTransactionHeader DO begin
            TelleringSetup.Get();
            SourceCodeSetup.Get();
            TransactionTpeCodeSetup.Get();
            TransactionTpeCodeSetup.TestField("Principal Paid");
            TransactionTpeCodeSetup.TestField("Interest Paid");
            SourceCodeSetup.TestField(Teller);
            TestField(Narration);

            UserSetup.Get("Teller User ID");



            JournalTemplateName := TelleringSetup."Teller Template Name";
            JournalBatchName := TelleringSetup."Teller Batch Name";
            CalcFields("Total Line Amount", "Total Coinage Amount");
            if "Total Line Amount" = 0 then
                Error('Teller Transaction Amount Cannot Be Zero');
            GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);
            ClearLastError();


            TellerTransactionLine.Reset();
            TellerTransactionLine.SetRange("Transaction No.", "No.");
            IF TellerTransactionLine.FindSet() THEN begin
                repeat
                    TransactionType.Get(TellerTransactionLine."Transaction Type");
                    GetTransactionCharges(TransactionType.Code, TellerTransactionLine."Line Amount", ChargeAmount[1]);
                    case TransactionType.Type of
                        TransactionType.Type::"Teller Cash Deposit":
                            begin
                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::"Savings/ shares" then begin
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 2, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                end;

                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::Loans then begin
                                    LoanApplication.get(TellerTransactionLine."Account No.");
                                    OriginalPostingGroup := LoanApplication."Loan Product Type";
                                    LoanProductType.GET(OriginalPostingGroup);

                                    Customer.get(TellerTransactionLine."Account No.");//
                                    Customer."Customer Posting Group" := OriginalPostingGroup;//
                                                                                              ///==================
                                    /* GlobalManagement.CalculateLoanArrearsAndOverpayment(TellerTransactionLine."Account No.", 0D, "Transaction Date", ArrearsAmount[1], ArrearsAmount[2],
                                     ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);*/
                                    GlobalManagement.CalculateLoanArrearsSTO(TellerTransactionLine."Account No.", 0D, "Transaction Date", ArrearsAmount[1], ArrearsAmount[2],
                                    OverpaymentAmount[1], OverpaymentAmount[2]);

                                    RemainingAmount := TellerTransactionLine."Line Amount";
                                    if TellerTransactionLine."Line Amount" > ArrearsAmount[2] then begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Interest Paid-' + "No." + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -ArrearsAmount[2], LoanProductType."Interest Due Posting Group", TransactionTpeCodeSetup."Interest Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        RemainingAmount -= ArrearsAmount[2];
                                    end else begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Interest Paid-' + "No." + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", LoanProductType."Interest Due Posting Group", TransactionTpeCodeSetup."Interest Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        RemainingAmount := 0;
                                    end;
                                    if RemainingAmount > 0 then begin
                                        Customer.get(TellerTransactionLine."Account No.");
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Principal Paid-' + "No." + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -RemainingAmount, OriginalPostingGroup, TransactionTpeCodeSetup."Principal Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                    end;
                                end;

                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::"G/L Account" then begin
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 0, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + ' Member No- ' + TellerTransactionLine."Member No." + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                end;
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 3, "Till No.", TellerTransactionLine."Transaction Type" + ' Member No- ' + TellerTransactionLine."Member No." + Narration, TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, UserSetup."Global Dimension 1 Code", BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                            end;
                        TransactionType.Type::"Teller Cash Withdrawal":
                            begin

                                AccountBalance := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, TellerTransactionLine."Account No.");
                                if AccountBalance < TellerTransactionLine."Line Amount" + ChargeAmount[1] then
                                    Error(InsufficientAccBalErrMsg);
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 2, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 2, TellerTransactionLine."Account No.", "No." + ' ' + TellerTransactionLine."Transaction Type" + '-Transaction Charges' + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, ChargeAmount[1], '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", TransactionType."Settlement Account Type", TransactionType."Settlement Account No.", "No." + ' ' + TellerTransactionLine."Transaction Type" + '-Transaction Charges' + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, -ChargeAmount[1], '', '', SourceCodeSetup.Teller, UserSetup."Global Dimension 1 Code", BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 3, "Till No.", TellerTransactionLine."Transaction Type" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, UserSetup."Global Dimension 1 Code", BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                            end;
                        TransactionType.Type::"Teller Cheque Withdrawal":
                            begin
                                TellerTransactionLine.TestField("Bank Acc No");
                                TellerTransactionLine.TestField("Cheque No");
                                AccountBalance := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, TellerTransactionLine."Account No.");
                                if AccountBalance < TellerTransactionLine."Line Amount" + ChargeAmount[1] then
                                    Error(InsufficientAccBalErrMsg);
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 2, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 2, TellerTransactionLine."Account No.", "No." + ' ' + TellerTransactionLine."Transaction Type" + 'Cheque No -' + TellerTransactionLine."Cheque No" + '-Transaction Charges' + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, ChargeAmount[1], '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", TransactionType."Settlement Account Type", TransactionType."Settlement Account No.", "No." + ' ' + TellerTransactionLine."Transaction Type" + '-Transaction Charges' + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, -ChargeAmount[1], '', '', SourceCodeSetup.Teller, UserSetup."Global Dimension 1 Code", BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 3, TellerTransactionLine."Bank Acc No", TellerTransactionLine."Transaction Type" + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, UserSetup."Global Dimension 1 Code", BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                            end;
                        TransactionType.Type::"Teller Cheque Deposit":
                            begin
                                TellerTransactionLine.TestField("Bank Acc No");
                                TellerTransactionLine.TestField("Cheque No");
                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::"Savings/ shares" then begin
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 2, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                end;

                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::Loans then begin
                                    LoanApplication.get(TellerTransactionLine."Account No.");
                                    OriginalPostingGroup := LoanApplication."Loan Product Type";
                                    LoanProductType.GET(OriginalPostingGroup);

                                    Customer.get(TellerTransactionLine."Account No.");
                                    Customer."Customer Posting Group" := OriginalPostingGroup;

                                    GlobalManagement.CalculateLoanArrearsAndOverpayment(TellerTransactionLine."Account No.", 0D, "Transaction Date", ArrearsAmount[1], ArrearsAmount[2],
                                    ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
                                    RemainingAmount := TellerTransactionLine."Line Amount";
                                    if TellerTransactionLine."Line Amount" > ArrearsAmount[2] then begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Interest Paid-' + "No." + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -ArrearsAmount[2], LoanProductType."Interest Due Posting Group", TransactionTpeCodeSetup."Interest Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        RemainingAmount -= ArrearsAmount[2];
                                    end else begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Interest Paid-' + "No." + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", LoanProductType."Interest Due Posting Group", TransactionTpeCodeSetup."Interest Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        RemainingAmount := 0;
                                    end;
                                    if RemainingAmount > 0 then begin
                                        Customer.get(TellerTransactionLine."Account No.");
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Principal Paid-' + "No." + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -RemainingAmount, OriginalPostingGroup, TransactionTpeCodeSetup."Principal Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                    end;
                                end;

                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::"G/L Account" then begin
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 0, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                end;
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 3, TellerTransactionLine."Bank Acc No", TellerTransactionLine."Transaction Type" + 'Cheque No -' + TellerTransactionLine."Cheque No" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, UserSetup."Global Dimension 1 Code", BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                            end;
                        TransactionType.Type::"Bank Deposit":
                            begin
                                TellerTransactionLine.TestField("Bank Acc No");
                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::"Savings/ shares" then begin
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 2, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                end;

                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::Loans then begin
                                    LoanApplication.get(TellerTransactionLine."Account No.");
                                    OriginalPostingGroup := LoanApplication."Loan Product Type";
                                    LoanProductType.GET(OriginalPostingGroup);

                                    Customer.get(TellerTransactionLine."Account No.");
                                    Customer."Customer Posting Group" := OriginalPostingGroup;

                                    GlobalManagement.CalculateLoanArrearsAndOverpayment(TellerTransactionLine."Account No.", 0D, "Transaction Date", ArrearsAmount[1], ArrearsAmount[2],
                                    ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
                                    RemainingAmount := TellerTransactionLine."Line Amount";
                                    if TellerTransactionLine."Line Amount" > ArrearsAmount[2] then begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Interest Paid-' + "No." + ' ' + TellerTransactionLine."Transaction Type" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -ArrearsAmount[2], LoanProductType."Interest Due Posting Group", TransactionTpeCodeSetup."Interest Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        RemainingAmount -= ArrearsAmount[2];
                                    end else begin
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Interest Paid-' + "No." + ' ' + TellerTransactionLine."Transaction Type" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", LoanProductType."Interest Due Posting Group", TransactionTpeCodeSetup."Interest Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                        RemainingAmount := 0;
                                    end;
                                    if RemainingAmount > 0 then begin
                                        Customer.get(TellerTransactionLine."Account No.");
                                        GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", GenJournalLine."Account Type"::Customer,
                                                      TellerTransactionLine."Account No.", 'Principal Paid-' + "No." + ' ' + TellerTransactionLine."Transaction Type" + ' - Member No ' + TellerTransactionLine."Member No." + ' ' + Narration, -RemainingAmount, OriginalPostingGroup, TransactionTpeCodeSetup."Principal Paid", SourceCodeSetup.Loan, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                    end;
                                end;

                                if TellerTransactionLine."Account Type" = TellerTransactionLine."Account Type"::"G/L Account" then begin
                                    GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 0, TellerTransactionLine."Account No.", TellerTransactionLine."Transaction Type" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, -TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, GetBranchCode(TellerTransactionLine."Member No."), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                                end;
                                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", "Transaction Date", 3, TellerTransactionLine."Bank Acc No", TellerTransactionLine."Transaction Type" + ' Member No- ' + TellerTransactionLine."Member No." + ' ' + Narration, TellerTransactionLine."Line Amount", '', '', SourceCodeSetup.Teller, UserSetup."Global Dimension 1 Code", BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
                            end;
                    end;
                until TellerTransactionLine.Next() = 0;
            end;

            IF GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName) then begin
                if Confirm(PrintTransactionReceiptConfirmMsg, true) then begin
                    TellerTransactionHeader.Get("No.");
                    TellerTransactionHeader.SETRECFILTER;
                    Report.Run(51104, true, false, TellerTransactionHeader);
                end;
                Posted := true;
                "Posted By" := UserId;
                "Posted Date" := Today;
                "Posted Time" := Time;
                IF Modify() then
                    CreateSMS(TellerTransactionHeader);
            end else
                Message(GetLastErrorText);
        end;
    end;

    local procedure GetTransactionCharges(TransactionTypeCode: Code[20]; TransactionAmount: Decimal; var ChargeAmount: Decimal)
    var
        TransactionCharge: Record "Transaction Charge";
        TellerTransType: Record "Transaction -Type";
    begin
        ChargeAmount := 0;
        TransactionCharge.Reset();
        TransactionCharge.SetRange("Transaction Type Code", TransactionTypeCode);
        if TransactionCharge.FindSet() then begin
            repeat
                if TellerTransType.Get(TransactionTypeCode) then begin
                    if (TellerTransType.Type = TellerTransType.Type::"Teller Cash Withdrawal") or (TellerTransType.Type = TellerTransType.Type::"Teller Cheque Withdrawal") then begin
                        if ((TransactionAmount >= TransactionCharge."Minimum Amount") and (TransactionAmount <= TransactionCharge."Maximum Amount")) then begin
                            ChargeAmount += TransactionCharge."Settlement Amount  (SACCO)";
                        end;
                    end;
                end;
            until TransactionCharge.Next() = 0;
        end;
    end;

    procedure CreateTellerReturnToTreasury(TellerTransactionHeader: Record "Teller Transaction Header")
    var
        TellerReturnToTreasury: Record "Teller Return Treasury";
    begin
        with TellerTransactionHeader do begin
            TellerUserSetup.Get("Teller User ID");
            TellerReturnToTreasury.Init();
            TellerReturnToTreasury."No." := '';
            TellerReturnToTreasury."Teller User ID" := "Teller User ID";
            TellerReturnToTreasury."Till No." := "Till No.";
            TellerReturnToTreasury."Till Return Amount" := Abs("Till Balance") - TellerUserSetup."Till Maximum Amount";
            TellerReturnToTreasury."Treasury Account No." := TellerUserSetup."Treasury Account No.";
            TellerreturnToTreasury.Status := TellerreturnToTreasury.Status::New;
            if TellerreturnToTreasury.Insert(true) then begin
                IF ApprovalsMgmt.CheckTellerReturnTreasuryApprovalPossible(TellerreturnToTreasury) THEN begin
                    ApprovalsMgmt.OnSendTellerReturnTreasuryForApproval(TellerreturnToTreasury);

                end;
            end;

        end;

    end;

    procedure PostTellerReturnToTreasury(var TellerReturnToTreasury: Record "Teller Return Treasury")
    var

    begin
        with TellerReturnToTreasury do begin
            CalcFields("Till Balance");
            If "Till Balance" < "Till Return Amount" then
                Error('Till Return Amount Cannot Exceed Till Balance');

            TelleringSetup.Get();
            JournalTemplateName := TelleringSetup."Teller Template Name";
            JournalBatchName := TelleringSetup."Teller Batch Name";

            GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);
            ClearLastError();
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Till No.", Description, -"Till Return Amount", '', '', SourceCodeSetup.Teller, '', BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Treasury Account No.", Description, "Till Return Amount", '', '', SourceCodeSetup.Teller, '', BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            IF GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName) then begin
                Posted := true;
                Modify();
            end else
                Message(GetLastErrorText);
        end;
    end;

    procedure PostFieldeturnCashier(var FieldReturnCashier: Record "Field Coll Return To Chashier")
    var

    begin
        with FieldReturnCashier do begin
            TelleringSetup.Get();
            JournalTemplateName := TelleringSetup."Teller Template Name";
            JournalBatchName := TelleringSetup."Teller Batch Name";

            GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);
            ClearLastError();
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Field Officer No.", Description, -"Till Return Amount", '', '', SourceCodeSetup.Teller, '', BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Cashier Account No.", Description, "Till Return Amount", '', '', SourceCodeSetup.Teller, '', BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            IF GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName) then begin
                Posted := true;
                Status := Status::Approved;
                Modify();
            end else
                Message(GetLastErrorText);
        end;
    end;

    procedure PostTellerReceiveFromTreasury(var TellerReturnToTreasury: Record "Teller Return Treasury")
    var
        Bank: Record "Bank Account";
    begin
        with TellerReturnToTreasury do begin
            Bank.Get("Treasury Account No.");
            Bank.CalcFields(Balance);
            If Bank.Balance < "Till Receive Amount" then
                Error('"Till Receive Amount" Cannot Exceed Treasury Balance');

            TelleringSetup.Get();
            JournalTemplateName := TelleringSetup."Teller Template Name";
            JournalBatchName := TelleringSetup."Teller Batch Name";

            GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);
            ClearLastError();
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Till No.", Description, "Till Receive Amount", '', '', SourceCodeSetup.Teller, '', BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Treasury Account No.", Description, -"Till Receive Amount", '', '', SourceCodeSetup.Teller, '', BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            IF GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName) then begin
                Posted := true;
                Modify();
            end else
                Message(GetLastErrorText);
        end;
    end;

    procedure CreateTellerTreasuryTransactionEntries(DocumentNo: Code[50]; PostingDate: Date; Description: Text[200]; TAmount: Decimal; TellerNo: Code[50]; Treasury: Code[50])
    var
        EntryNo: Integer;
        Trans: Record "Cashier Transaction Entries";
        TransN: Record "Cashier Transaction Entries";
    begin
        Trans.Reset();
        If Trans.FindLast() then
            EntryNo := Trans."Entry No" + 1
        else
            EntryNo := 1;

        TransN.Init();
        TransN."Entry No" := EntryNo;
        TransN."Cashier No" := TellerNo;
        TransN."Document No" := DocumentNo;
        TransN."Posting Date" := PostingDate;
        TransN.Description := Description;
        TransN."User ID" := UserId;
        If TAmount > 0 then
            TransN."Debit Amount" := TAmount
        else
            TransN."Credit Amount" := TAmount;
        TransN.Amount := TAmount;
        TransN.Insert();
    end;

    procedure CreateTellerRequestFromTreasury(TellerTransactionHeader: Record "Teller Transaction Header")
    var
        TreasuryTransactionHeader: Record "Treasury Transaction Header";

    begin
        with TellerTransactionHeader do begin
            TellerUserSetup.Get("Teller User ID");
            TreasuryTransactionHeader.Init();
            TreasuryTransactionHeader."No." := '';
            TreasuryTransactionHeader.validate("Treasury Account No.", TellerUserSetup."Treasury Account No.");
            TreasuryTransactionHeader.Status := TreasuryTransactionHeader.Status::New;
            if TreasuryTransactionHeader.Insert(true) then begin
                AddTreasuryTransactionLine(TreasuryTransactionHeader, TellerTransactionHeader);
            end;
        end;
    end;

    local procedure AddTreasuryTransactionLine(var TreasuryTransactionHeader: Record "Treasury Transaction Header"; TellerTransactionHeader: Record "Teller Transaction Header")
    var
        TreasuryTransactionLine: Record "Treasury Transaction Line";
        TreasuryTransactionLine2: Record "Treasury Transaction Line";
        LineNo: Integer;
    begin
        with TreasuryTransactionHeader do begin
            TreasuryTransactionLine.Init();
            TreasuryTransactionLine."Transaction No." := "No.";
            TreasuryTransactionLine2.Reset();
            TreasuryTransactionLine2.SetRange("Transaction No.", "No.");
            if TreasuryTransactionLine2.FindLast() then
                LineNo := TreasuryTransactionLine2."Line No."
            else
                LineNo := 0;
            TreasuryTransactionLine."Line No." := LineNo + 10000;
            TreasuryTransactionLine.validate("Till No.", TellerTransactionHeader."Till No.");
            TreasuryTransactionLine."Line Amount" := TellerUserSetup."Till Minimum Amount" - abs(TellerTransactionHeader."Till Balance");
            if TreasuryTransactionLine.Insert then begin
                IF ApprovalsMgmt.CheckTreasuryTransactionApprovalPossible(TreasuryTransactionHeader) THEN begin
                    ApprovalsMgmt.OnSendTreasuryTransactionForApproval(TreasuryTransactionHeader);
                end;
            end;
        end;
    end;

    procedure PostTreasuryTransaction(var TreasuryTransactionHeader: Record "Treasury Transaction Header")
    var
        TreasuryTransactionLine: Record "Treasury Transaction Line";

    begin
        with TreasuryTransactionHeader do begin
            TelleringSetup.Get();
            JournalTemplateName := TelleringSetup."Teller Template Name";
            JournalBatchName := TelleringSetup."Teller Batch Name";

            GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);
            ClearLastError();
            CalcFields("Total Amount", "Total Coinage Amount");

            TreasuryTransactionLine.Reset();
            TreasuryTransactionLine.SetRange("Transaction No.", "No.");
            if TreasuryTransactionLine.FindSet() then begin
                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, TreasuryTransactionLine."Till No.", Description, -TreasuryTransactionLine."Line Amount", '', '', SourceCodeSetup.Treasury, GetBranchCode(''), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            end;
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Treasury Account No.", Description, "Total Amount", '', '', SourceCodeSetup.Treasury, GetBranchCode(''), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');

            IF GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName) then begin
                Posted := true;
                Modify();
            end else
                Message(GetLastErrorText);
        end;
    end;

    procedure PostTreasuryReturnToBank(var TreasuryReturnToBankHeader: Record "Treasury Return Bank Header")
    var
        TreasuryReturnBankLine: Record "Treasury Return Bank Line";
    begin
        with TreasuryReturnToBankHeader do begin
            TelleringSetup.Get();
            JournalTemplateName := TelleringSetup."Teller Template Name";
            JournalBatchName := TelleringSetup."Teller Batch Name";

            GlobalManagement.ClearJournal(JournalTemplateName, JournalBatchName);
            ClearLastError();
            CalcFields("Total Amount", "Total Coinage Amount");

            TreasuryReturnBankLine.Reset();
            TreasuryReturnBankLine.SetRange("Transaction No.", "No.");
            if TreasuryReturnBankLine.FindSet() then begin
                GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, TreasuryReturnBankLine."Treasury Account No.", Description, -TreasuryReturnBankLine."Line Amount", '', '', SourceCodeSetup.Treasury, GetBranchCode(''), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            end;
            GlobalManagement.CreateJournal(JournalTemplateName, JournalBatchName, "No.", "No.", Today, 3, "Bank Account No.", Description, "Total Amount", '', '', SourceCodeSetup.Treasury, GetBranchCode(''), BalAccountTypeEnum::"G/L Account", '', AppliesToDocTypeEnum::" ", '');
            IF GlobalManagement.PostJournal(JournalTemplateName, JournalBatchName) then begin
                Posted := true;
                Modify();
            end else
                Message(GetLastErrorText);
        end;
    end;

    local procedure GetBranchCode(MemmberNo: Code[50]): Code[50]
    var
        Member: Record "Member";
        UserSetup: Record "User Setup";
    begin
        IF Member.Get(MemmberNo) then
            EXIT(Member."Global Dimension 1 Code");
    end;

    local procedure GetUserBranchCode(User: Code[50]): Code[50]
    var
        Member: Record "Member";
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.Get(User) then
            EXIT(UserSetup."Global Dimension 1 Code");
    end;

    local procedure CreateSMS(TellerTransactionHeader: Record "Teller Transaction Header")
    var
        TellerTransactionLine: Record "Teller Transaction Line";
        SMSText: BigText;
    begin

        with TellerTransactionHeader do begin
            CalcFields("Total Line Amount");
            Member.Get(TellerTransactionHeader."Member No.");

            TellerTransactionLine.Reset();
            TellerTransactionLine.SetRange("Transaction No.", "No.");
            if TellerTransactionLine.FindSet() then begin
                repeat
                    Clear(SMSText);
                    TransactionType.Get(TellerTransactionLine."Transaction Type");
                    if TransactionType.Type = TransactionType.Type::"Teller Cash Deposit" then begin
                        /* SMSText.AddText(StrSubstNo(DepositSMSTextMsg, "Total Line Amount"));
                         GlobalManagement.CreateSMSEntry(Member."Phone No.", SMSText, 'TELLER');
                     end;
                     if TransactionType.Type = TransactionType.Type::"Teller Cash Withdrawal" then begin
                         SMSText.AddText(StrSubstNo(WithdrawalSMSTextMsg, "Total Line Amount"));
                         GlobalManagement.CreateSMSEntry(Member."Phone No.", SMSText, 'TELLER');*/
                    end;
                until TellerTransactionLine.Next = 0;
            end;
        end;
    end;

    var
        i: Integer;
        NoSeriesMgt: Codeunit "No. Series";// TelleringSetup: Record "Tellering Setup";
        GenJournalLine: Record "Gen. Journal Line";
        TellerUserSetup: Record "Teller User Setup";
        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        PrintTransactionReceiptConfirmMsg: Label 'Do you want to print Transaction receipt?';
        GlobalManagement: Codeunit "Global Management";
        LoanProductType: Record "Loan Product Type";
        OriginalPostingGroup: Code[20];
        LoanApplication: Record "Loan Application";
        SourceCodeSetup: Record "Source Code Setup";
        Customer: Record Customer;
        SMSEntry: Record "SMS Entry";
        DepositSMSTextMsg: Label 'Dear Member, We have received KES %1. Unilands Sacco';
        WithdrawalSMSTextMsg: Label 'Dear Member, You have withdrawn KES %1. Unilands Sacco';
        Member: Record Member;
        TransactionType: Record "Transaction -Type";
        InsufficientAccBalErrMsg: Label 'Insufficient Account Balance';
        UserSetup: Record "User Setup";
        TelleringSetup: Record "Tellering Setup";
        AccountTypeEnum: Enum "Gen. Journal Account Type";
        BalAccountTypeEnum: Enum "Gen. Journal Account Type";
        AppliesToDocTypeEnum: Enum "Gen. Journal Document Type";
        TransactionTpeCodeSetup: Record "Transaction Type Code Setup";



}