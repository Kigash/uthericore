page 50005 Nominees
{
    // version TL2.0

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Beneficiary Type";

    SourceTableView = WHERE(Type = FILTER(Nominee));


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Allocation (%)"; Rec."Allocation (%)")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Person;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Person;
                }
                field("Front Side ID"; Rec."Front ID")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Person;
                }
                field("Back Side ID"; Rec."Back ID")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Person;
                }

            }
        }
        area(factboxes)
        {
            part("Nominee Picture"; "Nominee Picture")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = FIELD("Application No."), "Line No." = field("Line No.");

            }
            part("Nominee Front ID"; "Nominee Front ID")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = FIELD("Application No."), "Line No." = field("Line No.");

            }
            part("Nominee Back ID"; "Nominee Back ID")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = FIELD("Application No."), "Line No." = field("Line No.");

            }
            part("Nominee Signature"; "Nominee Signature")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = FIELD("Application No."), "Line No." = field("Line No.");

            }
        }

    }
}


