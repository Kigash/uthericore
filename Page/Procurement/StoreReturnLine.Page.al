page 50737 "Store Return Line"
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Quantity Returned"; Rec."Quantity Returned")
                {
                    ApplicationArea = All;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                }
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                    Editable = false;
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

