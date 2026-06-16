table 50027 "Check Off Company"
{
    Caption = 'Check Off Company';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Employer Company List";
    LookupPageID = "Employer Company List";

    fields
    {
        field(1; "Company Code"; Code[50])
        {
            Caption = 'Company Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Company Name"; Text[250])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Company Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Company Code", "Company Name")
        {

        }
    }
    trigger OnInsert()
    var
        ResourcesSetup: Record "Resources Setup";
        Resource: Record Resource;
        CashMSetup: Record "Cash Management Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        CashMSetup.Get();
        if "Company Code" = '' then begin
            CashMSetup.TestField("Employer Nos.");
            "Company Code" := NoSeriesMgt.GetNextNo(CashMSetup."Employer Nos.");
        end;
    end;
}
