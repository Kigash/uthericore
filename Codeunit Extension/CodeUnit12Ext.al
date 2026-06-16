codeunit 50014 CodeUnit12Ext
{
    //Gen. Jnl.-Post Line
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostVend', '', false, false)]
    local procedure OnAfterPostVend(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
    begin
        with GenJournalLine do begin
            if "Account Type" = "Account Type"::Vendor then begin
                if "Credit Amount" > 0 then begin
                    Vendor.Get("Account No.");
                    AccountTypes.RESET;
                    AccountTypes.SETRANGE(Code, Vendor."Account Type");
                    AccountTypes.SETRANGE(Type, AccountTypes.Type::"Member Deposit");
                    IF AccountTypes.FINDSET THEN BEGIN
                        IF Vendor.Status = Vendor.Status::Dormant THEN BEGIN
                            Vendor.Status := Vendor.Status::Active;
                            Vendor.Modify();
                        END;
                    END;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeBankAccLedgEntryInsert', '', false, false)]
    local procedure OnPostBankAccOnBeforeBankAccLedgEntryInsert(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account")
    begin
        with GenJournalLine do begin

        end;
    end;
}
