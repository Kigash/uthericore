codeunit 50021 "Reversal Entry Ext"
{
    TableNo = "Reversal Entry";

    //OnAfterCopyFromVendLedgEntry
    /*
        [EventSubscriber(ObjectType::Table, Codeunit::"Reversal Entry Ext", 'OnAfterCopyFromVendLedgEntry', '', false, false)]
        local procedure OnAfterInsertFromVendLedgEntry(var TempRevertTransactionNo: Record "Integer"; Number: Integer; RevType: Option Transaction,Register; var NextLineNo: Integer; var TempReversalEntry: Record "Reversal Entry" temporary; var VendLedgEntry: Record "Vendor Ledger Entry")
        var
            Vend: Record Vendor;
            AccType: Record "Account Type";
            Memb: Record Member;
            SmSEntry: Record "SMS Entry";
            EntryNo: Integer;
            GlobalManagement: Codeunit "Global Management";
            SMSText: BigText;
            SourceCodeSetup: Record "Source Code Setup";
            AmountRev: Decimal;
        begin
            AmountRev := 0;
            Message('Reversal');
            AccType.Reset();
            AccType.SetRange(Type, AccType.Type::Savings);
            AccType.SetRange("Sub Type", AccType."Sub Type"::"Field Collection");
            If AccType.FindFirst() then begin
                Vend.Reset();
                Vend.SetRange("Account Type", AccType.Code);
                Vend.SetRange("No.", VendLedgEntry."Vendor No.");
                If Vend.FindFirst() then begin
                    VendLedgEntry.CalcFields("Debit Amount", "Credit Amount");
                    If VendLedgEntry."Credit Amount" > 0 then
                        AmountRev := VendLedgEntry."Credit Amount"
                    else
                        AmountRev := VendLedgEntry."Debit Amount";

                    Memb.Get(Vend."Member No.");
                    CLEAR(SMSText);
                    SMSText.ADDTEXT(STRSUBSTNO('Dear Member, your Field collection transaction of amount Ksh %1 on %2 has been reversed successfuly.', AmountRev, VendLedgEntry."Posting Date"));
                    GlobalManagement.CreateSMSEntry(Memb."Phone No.", SMSText, SourceCodeSetup.Loan);
                end;
            end;
        end;
        */
}
