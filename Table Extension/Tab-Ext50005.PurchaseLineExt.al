tableextension 50005 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        modify("VAT Bus. Posting Group")
        {
            trigger OnBeforeValidate()
            begin
                Clear("VAT Prod. Posting Group");
            end;

            trigger OnAfterValidate()
            var
                VATSetup: Record "VAT Posting Setup";
            begin
                VATSetup.Reset();
                VATSetup.SetRange("VAT Bus. Posting Group", Rec."VAT Bus. Posting Group");
                if VATSetup.FindFirst() then begin
                    "VAT Prod. Posting Group" := VATSetup."VAT Prod. Posting Group";
                end;
            end;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                "Gen. Bus. Posting Group" := 'GENERAL';
                "Gen. Prod. Posting Group" := 'GENERAL';
            end;
        }
    }
}
