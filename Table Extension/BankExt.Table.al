tableextension 50169 "Bank Ext" extends "Bank Account"
{
    fields
    {
        field(50000; "Account Type"; Option)
        {
            OptionCaption = 'Bank Account,Till Account,Treasury Account,Field Collection';
            OptionMembers = "Bank Account","Till Account","Treasury Account","Field Collection";
        }
        field(50001; "Paybill Bank"; Boolean)
        {

        }
        field(50002; "Member No."; Code[20])
        {
            TableRelation = Member;

            trigger OnValidate()
            var

            begin
                Member.Get("Member No.");
                "Member Name" := Member."Full Name";
            end;
        }
        field(50003; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(50004; "Agent"; Boolean)
        {

        }
        field(50005; "Agent Phone No."; code[20])
        {

        }
        field(50006; "Cashier Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
        }
        field(50007; "Treasury Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
        }
    }


    var
        Member: Record Member;
}