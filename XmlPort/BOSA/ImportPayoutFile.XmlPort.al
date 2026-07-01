xmlport 50001 "Import Payout File"
{
    // version TL2.0

    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(MemberNo)
                {
                }
                textelement(Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Integer.SETRANGE(Number, 1, 1);
                end;

                trigger OnAfterInsertRecord()
                var
                    ChargeAmount: array[4] of Decimal;
                    PayoutChargeRange: Record "Payout Charge Range";
                begin

                    i += 1;
                    PayoutLine.INIT;
                    IF i > 1 THEN BEGIN
                        WITH PayoutLine DO BEGIN
                            "Document No." := DocumentNo;
                            "Line No." := GetLastLineNo(DocumentNo) + 1;
                            VALIDATE("Member No.", MemberNo);
                            VALIDATE("Account No.", GetAccountNo(MemberNo, PayoutSetup."FOSA Account Type"));
                            EVALUATE("Gross Amount", Amount);
                            ChargeAmount[1] := 0;
                            ChargeAmount[2] := 0;
                            ChargeAmount[3] := 0;

                            IF PayoutHeader."Charge Calculation Method" = PayoutHeader."Charge Calculation Method"::"Flat Amount" THEN
                                ChargeAmount[1] := PayoutHeader."Flat Charge Amount";

                            IF PayoutHeader."Charge Calculation Method" = PayoutHeader."Charge Calculation Method"::"Percentage" THEN
                                ChargeAmount[1] := (PayoutHeader."Charge Percentage" / 100) * "Gross Amount";

                            IF PayoutHeader."Charge Calculation Method" = PayoutHeader."Charge Calculation Method"::Range THEN BEGIN
                                PayoutChargeRange.RESET;
                                PayoutChargeRange.SetRange("Document No.", PayoutHeader."No.");
                                if PayoutChargeRange.FindSet() then begin
                                    repeat
                                        if ("Gross Amount" >= PayoutChargeRange."Minimum Amount") and ("Gross Amount" <= PayoutChargeRange."Maximum Amount") then begin
                                            ChargeAmount[1] := PayoutChargeRange."Charge Amount";
                                        end;
                                    until PayoutChargeRange.Next() = 0;
                                end;
                            END;
                            "Charge Amount" := ChargeAmount[1];
                            "Net Amount" := "Gross Amount" - ChargeAmount[1];
                            IF "Net Amount" > 0 THEN
                                "Net Amount" := "Net Amount"
                            ELSE
                                "Net Amount" := 0;
                            INSERT(TRUE);
                        END;
                    END;
                end;
            }
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

    trigger OnPostXmlPort()
    begin
        PayoutLine.RESET;
        IF PayoutLine.GET(DocumentNo, 0) THEN
            PayoutLine.DELETE;
    end;

    trigger OnPreXmlPort()
    begin
        GlobalSetup.GET;
        PayoutSetup.GET;

        PayoutLine.RESET;
        PayoutLine.SETRANGE("Document No.", DocumentNo);
        PayoutLine.DELETEALL;
    end;

    var
        Text000: Label 'Records Uploaded successfully!';
        PayoutLine: Record "Payout Line";
        i: Integer;
        DocumentNo: Code[20];
        LineNo: Integer;
        Member: Record "Member";
        PayoutSetup: Record "Payout Setup";
        GlobalSetup: Record "Global Setup";
        PayoutHeader: Record "Payout Header";

    procedure SetPayoutNo(var PayoutNo: Code[20])
    begin
        DocumentNo := PayoutNo;
    end;

    local procedure GetLastLineNo(DocumentNo: Code[20]): Integer
    var
        PayoutLine: Record "Payout Line";
    begin
        PayoutLine.RESET;
        PayoutLine.SETRANGE("Document No.", DocumentNo);
        IF PayoutLine.FINDLAST THEN
            EXIT(PayoutLine."Line No.")
        ELSE
            EXIT(0);
    end;

    local procedure GetAccountNo(MemberNo: Code[20]; AccountTypeCode: Code[20]): Code[20]
    var
        AccountType: Record "Account Type";
        Vendor: Record "Vendor";
    begin
        AccountType.GET(AccountTypeCode);
        Vendor.RESET;
        Vendor.SETRANGE("Member No.", MemberNo);
        Vendor.SETRANGE("Account Type", AccountType.Code);
        IF Vendor.FINDFIRST THEN
            EXIT(Vendor."No.");
    end;
}