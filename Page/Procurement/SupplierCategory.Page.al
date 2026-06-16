page 50750 "Supplier Category"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Supplier Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("No. Prequalified"; Rec."No. Prequalified")
                {
                    ApplicationArea = All;
                }
                field("Year Filter"; Rec."Year Filter")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

