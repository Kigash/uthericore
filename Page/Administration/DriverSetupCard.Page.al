page 51015 "Driver Setup Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Driver Setup";

    layout
    {
        area(content)
        {
            group(Driver)
            {
                field("Full Names"; Rec."Full Names")
                {
                    ApplicationArea = All;

                }
                field("ID NO."; Rec."ID NO.")
                {
                    ApplicationArea = All;

                }
                field("Driving License"; Rec."Driving License")
                {
                    ApplicationArea = All;

                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Save Driver Details")
            {
                Image = Save;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin

                    Rec.TESTFIELD("Full Names");
                    Rec.TESTFIELD("ID NO.");

                    MESSAGE(TEXT001);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        driver: Record "Driver Setup";
        AdminManagement: Codeunit "Admin Management";
        TEXT001: Label 'Details saved succesfully.';
}

