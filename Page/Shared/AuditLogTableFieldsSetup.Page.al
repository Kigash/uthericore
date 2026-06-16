page 50386 "Audit Log Table Fields Setup"
{
    // version MC2.0

    Caption = 'Table Fields Setup';
    PageType = List;
    SourceTable = "Audit Log Table Field Setup";

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
                field("Field No."; Rec."Field No.")
                {
                }
                field("Field Name"; Rec."Field Name")
                {
                }
                field("On Insert"; Rec."On Insert")
                {
                }
                field("On Modify"; Rec."On Modify")
                {
                }
                field("On Delete"; Rec."On Delete")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("User Access")
            {
                Image = UserSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Audit Log User Access Setup";
                RunPageLink = "Field No." = FIELD("Field No."),
                              "Field No." = FIELD("Field No.");
            }
        }
    }
}

