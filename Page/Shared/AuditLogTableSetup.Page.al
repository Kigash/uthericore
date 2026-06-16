page 50383 "Audit Log Table Setup"
{
    // version MC2.0

    Caption = 'Audit Log Setup';
    PageType = List;
    SourceTable = "Audit Log Table Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table No."; Rec."Table No.")
                {
                }
                field("Table Name"; Rec."Table Name")
                {
                }
                field("Activate Log"; Rec."Activate Log")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Table Fields")
            {
                Image = SelectField;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Audit Log Table Fields Setup";
                RunPageLink = "Table No." = FIELD("Table No.");
            }
        }
    }
}

