codeunit 50150 "No Series Management"
{
    // Minimal fallback NoSeriesManagement for compilation only.

    procedure GetNextNo(NoSeriesCode: Code[20]; PrevNoSeries: Code[20]; PostingDate: Date; var No: Code[20]; var NoSeries: Code[20])
    begin
        // Minimal initializer: generate next no and set the series
        No := GetNextNo(NoSeriesCode, PostingDate, true);
        NoSeries := NoSeriesCode;
    end;

    procedure GetNextNo(NoSeriesCode: Code[20]; PostingDate: Date; Reserve: Boolean) Result: Code[20]
    var
        guidText: Text[50];
    begin
        // Simple fallback: use part of a GUID to provide a reasonably-unique value.
        // This is intentionally minimal â€” replace with proper No. Series logic or
        // add the original NoSeriesManagement implementation if available.
        guidText := FORMAT(CreateGuid());
        // Trim to keep the result short
        Result := CopyStr(NoSeriesCode, 1, 8) + '-' + CopyStr(guidText, 1, 12);
        exit(Result);
    end;

}
