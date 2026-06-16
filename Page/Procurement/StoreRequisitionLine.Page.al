page 50731 "Store Requisition Line"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Requisition Header Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan Item"; Rec."Procurement Plan Item")
                {
                    ApplicationArea = All;
                }
                field("Budget Link"; Rec."Budget Link")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Quantity in Store"; Rec."Quantity in Store")
                {
                    ApplicationArea = All;
                }
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        GeneralLedgerSetup.GET;
        Rec."Procurement Plan" := GeneralLedgerSetup."Current Bugdet";
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
}

