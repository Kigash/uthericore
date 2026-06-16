page 50704 "Procurement Plan FactBox"
{
    // version TL2.0

    PageType = CardPart;
    SourceTable = "Procurement Plan Header";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Current Budget"; Rec."Current Budget")
            {
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
            field("Budget Period"; Rec."Budget Period")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        AmountsEstimated: Decimal;
        ProcurementManagement: Codeunit "Procurement Management";
}

