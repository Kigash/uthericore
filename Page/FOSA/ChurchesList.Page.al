page 51305 Churches
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Church;

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
                /*                 field("Church Section Code"; Rec."Church Section Code")
                                {
                                    ApplicationArea = All;

                                } */
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
            /*   action(ActionName)
              {
                  ApplicationArea = All;

                  trigger OnAction();
                  begin

                  end;
              } */
        }
    }
}