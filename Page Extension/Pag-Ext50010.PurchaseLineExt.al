pageextension 50010 PurchaseLineExt extends "Purch. Invoice Subform"
{
    layout
    {
        
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            ShowMandatory = true;
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        VATsetup: Record "VAT Posting Setup";
    begin

        VATsetup.Reset();
        VATsetup.SetFilter("VAT Bus. Posting Group", '<>%1', '');
        If VATsetup.FindFirst() then begin
            //Rec."VAT Bus. Posting Group" := VATsetup."VAT Bus. Posting Group";
            //Rec."VAT Prod. Posting Group" := VATsetup."VAT Prod. Posting Group";
        end;
    end;
}
