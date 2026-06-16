page 50744 "Procurement Request Line"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Procurement Request Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
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
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan Item"; Rec."Procurement Plan Item")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Store"; Rec."Quantity in Store")
                {
                    ApplicationArea = All;
                }
                field("Approved Budget Amount"; Rec."Approved Budget Amount")
                {
                    ApplicationArea = All;
                }
                field("Commitment Amount"; Rec."Commitment Amount")
                {
                    ApplicationArea = All;
                }
                field("Actual Expense"; Rec."Actual Expense")
                {
                    ApplicationArea = All;
                }
                field("Available amount"; Rec."Available amount")
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
}

