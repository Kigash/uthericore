codeunit 50030 "Update Cheque Charges"
{
    var
        TellerT: Record "Teller Transaction Header";
        Tellering: Codeunit "Tellering & Treasury";

    trigger OnRun()
    begin
        TellerT.Reset();
        TellerT.SetRange(Posted, true);
        if TellerT.FindSet() then begin
            repeat
                Tellering.PostTellerTransactionCorrection(TellerT);
            until TellerT.Next() = 0;
        end;
    end;
}
