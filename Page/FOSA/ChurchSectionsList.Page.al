page 51304 "Church Sections"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Church Section";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field("Church District Code"; Rec."Church District Code")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            /*    action(ActionName)
               {
                   ApplicationArea = All;

                   trigger OnAction();
                   begin

                   end;
               } */
        }
    }
}