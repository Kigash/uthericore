page 50502 "Bracket Table Setup"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Bracket Table";

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Effective Starting Date"; Rec."Effective Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Effective End Date"; Rec."Effective End Date")
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
            //Caption = 'General';
            group(Braket)
            {
                action("Bracket Lines")
                {
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bracket Lines";
                    RunPageLink = "Table Code" = FIELD("Table Code");
                    ApplicationArea = All;
                }
            }
        }
        area(Processing)
        {
            action(Lines)
            {
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bracket Lines";
                RunPageLink = "Table Code" = FIELD("Table Code");
            }
        }
    }
}

