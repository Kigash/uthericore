tableextension 50003 BankAccStatmntExt extends "Bank Account Statement"
{
    fields
    {
        modify("Statement Date")
        {
            trigger OnAfterValidate()
            var
                Dfilter: Text;
                BankL: Record "Bank Account Ledger Entry";
            begin
                if "Statement Date" <> 0D then begin
                    Dfilter := '..' + Format("Statement Date");
                    BankL.Reset();
                    BankL.SetRange(BankL."Bank Account No.", "Bank Account No.");
                    BankL.SetFilter(BankL."Posting Date", Dfilter);
                    if BankL.FindSet() then begin
                        BankL.CalcSums(Amount);
                        "Cash Book Balance" := BankL.Amount;
                    end;
                end;
            end;
        }
        field(50001; "Cash Book Balance"; Decimal)
        {
            Caption = 'Cash Book Balance';
        }
    }
}
