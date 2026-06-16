page 50503 "Bracket Lines"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Bracket Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Code"; Rec."Table Code")
                {
                    ApplicationArea = All;
                }
                field(Descripption; Rec.Descripption)
                {
                    ApplicationArea = All;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Taxable Pay"; Rec."Taxable Pay")
                {
                    Editable = false;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Amount Charged"; Rec."Amount Charged")
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Pay period"; Rec."Pay period")
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

